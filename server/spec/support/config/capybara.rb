require 'capybara/poltergeist'

driver = :selenium_chrome

case driver
when :selenium_chrome
  Capybara.register_driver :selenium_chrome do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome)
  end
  Capybara.default_driver = :selenium_chrome
  Capybara.javascript_driver = :selenium_chrome
when :poltergeist
  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, js_errors: false)
  end
  Capybara.default_driver = :poltergeist
  Capybara.javascript_driver = :poltergeist
end

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
