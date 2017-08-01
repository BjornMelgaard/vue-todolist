# https://github.com/DockYard/capybara-email#setting-your-test-host
client_port = ENV['CLIENT_PORT']

if client_port.blank?
  puts 'Warning: No CLIENT_PORT'
  puts 'Feature tests will probably fail'
else
  Capybara.app_host = "http://localhost:#{client_port}"
  Capybara.run_server = false
end

driver = :local_chrome

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
  # usage:
  # start client - cd client && yarn run test:debug
  # start server - cd server && RAILS_LOG_TO_STDOUT=true rails s -p $SERVER_PORT_TEST -e test
  # close chrome and reopen with 'google-chrome-stable --remote-debugging-port=4444'
  # run tests -    cd server && CLIENT_PORT=$CLIENT_PORT_TEST rspec spec/features
  # why:
  # great for bdd spa applications
  # test server with logging
  # spa rendering debug with nodejs-chrome extention

  Capybara.register_driver :local_chrome do |app|
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_option('debuggerAddress', '127.0.0.1:4444')

    Capybara::Selenium::Driver.new(app,
                                   browser: :chrome,
                                   options: options)
  end

  Capybara.javascript_driver = :local_chrome
  Capybara.default_driver    = :local_chrome
end
