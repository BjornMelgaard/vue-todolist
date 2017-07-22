require 'capybara/poltergeist'

if ENV['RSPEC_SELENIUM']
  Capybara.register_driver :selenium_chrome do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome)
  end
  Capybara.default_driver = :selenium_chrome
  Capybara.javascript_driver = :selenium_chrome
else
  # Capybara.register_driver :poltergeist do |app|
  #   Capybara::Poltergeist::Driver.new(app, js_errors: false)
  # end
  Capybara.default_driver = :poltergeist
  Capybara.javascript_driver = :poltergeist
end

# https://github.com/DockYard/capybara-email#setting-your-test-host
Capybara.server_port = 3001
Capybara.app_host = 'http://localhost:3001'
