# https://github.com/DockYard/capybara-email#setting-your-test-host
server_port = ENV['PORT']
client_port = ENV['CLIENT_PORT']

if !server_port || !client_port
  puts 'Warning: No PORT' unless server_port
  puts 'Warning: No CLIENT_PORT' unless client_port
  puts 'Feature tests will probably fail'
else
  Capybara.server_port = server_port
  Capybara.app_host = "http://localhost:#{client_port}"
end

driver = :chrome

case driver
when :chrome
  Capybara.register_driver :chrome do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome)
  end
  Capybara.default_driver = :chrome
  Capybara.javascript_driver = :chrome
when :poltergeist
  require 'capybara/poltergeist'

  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, js_errors: false)
  end
  Capybara.default_driver = :poltergeist
  Capybara.javascript_driver = :poltergeist
when :local_chrome
  # usage - close chrome and reopen with 'google-chrome-stable --remote-debugging-port=4444'

  Capybara.register_driver :local_chrome do |app|
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_option('debuggerAddress', '127.0.0.1:4444')

    Capybara::Selenium::Driver.new(app,
                                   browser: :chrome,
                                   options: options)
  end

  Capybara.javascript_driver = :local_chrome
  Capybara.default_driver    = :local_chrome

  # RSpec.configure do |config|
  #   config.before(:each, type: :feature) do
  #     require 'pry'; ::Kernel.binding.pry;
  #     # visit('')
  #   end
  # end
end
