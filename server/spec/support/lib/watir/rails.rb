# shamelessly stolen from watir-rails

require 'uri'
require 'net/http'
require 'rack'
require 'watir'

begin
  require 'rails'
rescue LoadError
  # Load legacy Rails
  require 'initializer'
end

module Watir
  class Rails
    # @private
    class Middleware
      attr_accessor :error

      def initialize(app)
        @app = app
      end

      def call(env)
        if env['PATH_INFO'] == '/__identify__'
          [200, {}, [@app.object_id.to_s]]
        else
          begin
            @app.call(env)
          rescue => e
            @error = e
            raise e
          end
        end
      end
    end

    class << self
      private :new
      attr_reader :port, :middleware
      attr_writer :ignore_exceptions

      # Start the Rails server for tests.
      # Will be called automatically by {Watir::Browser#initialize}.
      def boot(port = nil)
        unless running?
          @middleware = Middleware.new(app)
          @port = port || find_available_port

          @server_thread = Thread.new do
            run_default_server @middleware, @port
          end

          Timeout.timeout(boot_timeout) { @server_thread.join(0.1) until running? }
        end
      rescue Timeout::Error
        raise Timeout::Error, 'Rails Rack application timed out during boot'
      end

      # Host for Rails app under test. Default is {.local_host}.
      #
      # @return [String] Host for Rails app under test.
      def host
        @host || local_host
      end

      # Set host for Rails app. Will be used by {Browser#goto} method.
      #
      # @param [String] host host to use when using {Browser#goto}.
      attr_writer :host

      # Local host for Rails app under test.
      #
      # @return [String] Local host with the value of "127.0.0.1".
      def local_host
        '127.0.0.1'
      end

      # Error rescued by the middleware.
      #
      # @return [Exception or NilClass]
      def error
        @middleware.error
      end

      # Set error rescued by the middleware.
      #
      # @param value
      def error=(value)
        @middleware.error = value
      end

      # Check if Rails exceptions should be ignored. Defaults to false.
      #
      # @return [Boolean] true if exceptions should be ignored, false otherwise.
      def ignore_exceptions?
        if @ignore_exceptions.nil?
          show_exceptions = if legacy_rails?
                              ::Rails.configuration.action_dispatch.show_exceptions
                            else
                              ::Rails.application.config.action_dispatch.show_exceptions
                 end

          if show_exceptions
            warn '[WARN] "action_dispatch.show_exceptions" is set to "true", disabling watir-rails exception catcher.'
            @ignore_exceptions = true
          end
        end

        !!@ignore_exceptions
      end

      # Check if Rails app under test is running.
      #
      # @return [Boolean] true when Rails app under test is running, false otherwise.
      def running?
        return false if @server_thread && @server_thread.join(0)

        res = Net::HTTP.start(local_host, @port) { |http| http.get('/__identify__') }

        if res.is_a?(Net::HTTPSuccess) || res.is_a?(Net::HTTPRedirection)
          return res.body == @app.object_id.to_s
        end
      rescue Errno::ECONNREFUSED, Errno::EBADF
        return false
      end

      # Rails app under test.
      #
      # @return [Object] Rails Rack app.
      def app
        legacy = legacy_rails?
        @app ||= Rack::Builder.new do
          map '/' do
            if legacy
              use ::Rails::Rack::Static
              run ActionController::Dispatcher.new
            else
              run ::Rails.application
            end
          end
        end.to_app
      end

      private

      def boot_timeout
        60
      end

      def find_available_port
        server = TCPServer.new(local_host, 0)
        server.addr[1]
      ensure
        server&.close
      end

      def run_default_server(app, port)
        begin
          require 'rack/handler/thin'
          Thin::Logging.silent = true
          return Rack::Handler::Thin.run(app, Port: port)
        rescue LoadError
        end

        begin
          require 'rack/handler/puma'
          return Rack::Handler::Puma.run(app, Port: port, Silent: true)
        rescue LoadError
        end

        require 'rack/handler/webrick'
        Rack::Handler::WEBrick.run(app, Port: port, AccessLog: [], Logger: WEBrick::Log.new(nil, 0))
      end

      def legacy_rails?
        ::Rails.version.to_f < 3.0
      end
    end
  end
end

module Watir
  # Reopened Watir::Browser class for working with Rails
  class Browser
    # @private
    alias _original_initialize initialize

    # Will start Rails instance for Watir automatically and then invoke the
    # original Watir::Browser#initialize method.
    def initialize(browser, **args)
      server_port = args.delete(:server_port)
      @app_host   = args.delete(:app_host)

      Rails.boot(server_port)
      _original_initialize browser, **args
      add_exception_hook unless Rails.ignore_exceptions?
    end

    def visit(url)
      goto "http://#{@app_host}#{url}"
    end

    private

    def add_exception_hook
      after_hooks.add do
        if error = Rails.error
          Rails.error = nil
          raise error
        end
      end
    end
  end
end