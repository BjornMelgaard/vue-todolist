require 'watir/rspec'
require_relative '../lib/watir/rails'

RSpec.configure do |config|
  # Use Watir::RSpec::HtmlFormatter to get links to the screenshots, html and
  # all other files created during the failing examples.
  config.add_formatter(:progress) if config.formatters.empty?
  config.add_formatter(Watir::RSpec::HtmlFormatter)

  # Open up the browser for each example.
  config.before :all, type: :integration do
    server_port = ENV['PORT']
    client_port = ENV['CLIENT_PORT']
    raise 'Warning: No PORT' unless server_port
    raise 'Warning: No CLIENT_PORT' unless client_port
    debugger_port = 4444
    app_host = "http://localhost:#{client_port}"

    options = Selenium::WebDriver::Chrome::Options.new
    options.add_option('debuggerAddress', "127.0.0.1:#{debugger_port}")
    @browser = Watir::Browser.new :chrome,
                                  options: options,
                                  server_port: server_port,
                                  app_host: app_host

    unless @browser.url.start_with?(app_host)
      # open new tab
      # @browser.execute_script("window.open('about:blank','_blank');")
      # @browser.driver.action.key_down(:control).send_keys('t').key_up(:control).perform
      # @browser.driver.action.send_keys(:control, 't').perform

      # goto
      @browser.goto(app_host)
    end
  end

  # Close that browser after each example.
  config.after :all, type: :integration do
    @browser&.close
  end

  # Include RSpec::Helper into each of your example group for making it possible to
  # write in your examples instead of:
  #   @browser.goto "localhost"
  #   @browser.text_field(name: "first_name").set "Bob"
  #
  # like this:
  #   goto "localhost"
  #   text_field(name: "first_name").set "Bob"
  #
  # This needs that you've used @browser as an instance variable name in
  # before :all block.
  config.include Watir::RSpec::Helper, type: :integration

  # Include RSpec::Matchers into each of your example group for making it possible to
  # use #within with some of RSpec matchers for easier asynchronous testing:
  #   expect(@browser.text_field(name: "first_name")).to exist.within(2)
  #   expect(@browser.text_field(name: "first_name")).to be_present.within(2)
  #   expect(@browser.text_field(name: "first_name")).to be_visible.within(2)
  #
  # You can also use #during to test if something stays the same during the specified period:
  #   expect(@browser.text_field(name: "first_name")).to exist.during(2)
  config.include Watir::RSpec::Matchers, type: :integration
end
