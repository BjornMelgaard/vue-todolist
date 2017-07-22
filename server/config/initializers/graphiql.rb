return unless Rails.env.development?

email    = ENV['GRAPHIQL_USER']
password = ENV['GRAPHIQL_PASSWORD']

raise if email.blank? || password.blank?

user = User.find_by(email: email)

auth_headers = user.create_new_auth_token

# unfortunatelly GraphiQL headers can be only in type [Hash<String => Proc>]
auth_headers.each do |key, value|
  GraphiQL::Rails.config.headers[key] = ->(_) { value }
end
