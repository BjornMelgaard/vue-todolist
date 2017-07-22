RSpec.configure do |config|
  config.after(:each) do |example|
    next unless example.metadata[:type] == :request && example.exception.present?

    begin
      pp json_body
    rescue Airborne::InvalidJsonError
      next if body.blank?
      file = Tempfile.new(['body', '.html'])
      file.write(body)
      file.close
      `xdg-open #{file.path}`
    rescue NoMethodError
      next
    end
  end
end
