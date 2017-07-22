# usually used for graphiql
email    = ENV['GRAPHIQL_USER']
password = ENV['GRAPHIQL_PASSWORD']

raise if email.blank? || password.blank?

user = User.find_or_create_by(email: email) do |u|
  u.password = password
end

FactoryGirl.create_list(:project, 3, user: user)
