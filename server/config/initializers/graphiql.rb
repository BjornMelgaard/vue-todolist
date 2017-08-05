def get_user_token(email, password)
  client = Auth0Client.new(
    client_id:   ENV['AUTH0_CLIENT_ID'],
    token:       ENV['AUTH0_API_TOKEN'],
    domain:      ENV['AUTH0_DOMAIN'],
    api_version: 2
  )
  require 'pry'; ::Kernel.binding.pry;
  client.login(email, password)
end

get_user_token(ENV['GRAPHIQL_USER'], ENV['GRAPHIQL_PASSWORD'])

if Rails.env.development?
  GraphiQL::Rails.config.headers['Authorization'] = -> (_) do
    "Bearer #{get_user_token(ENV['GRAPHIQL_USER'], ENV['GRAPHIQL_PASSWORD'])}"
  end
end
