module GraphqlHelpers
  def graphql_request(data, headers: nil)
    post '/graphql', params: data, headers: headers
  end

  def queryfile_content(name)
    File.read Rails.root.join("spec/queries/#{name}.graphql")
  end
end

RSpec.configure do |config|
  config.include GraphqlHelpers, type: :request
end
