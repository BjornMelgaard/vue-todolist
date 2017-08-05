Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/api/edge/graphql'
  end

  get '/ping', to: 'secured_ping#ping'

  scope '/api/edge' do
    post '/graphql', to: 'graphql#execute'
    # mount_devise_token_auth_for 'User', at: 'auth'
    get 'members_only', to: 'demo_user#members_only'
  end
end
