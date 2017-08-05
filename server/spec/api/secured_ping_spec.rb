require 'rails_helper'

RSpec.describe 'Secured Ping: ', type: :request do
  def auth_headers
    user = create :user
    token = Knock::AuthToken.new(payload: { sub: user.id }).token
    { 'Authorization': "Bearer #{token}" }
  end

  it 'responds with unauthorized' do
    get '/ping', as: :json
    expect_status :unauthorized
  end

  it 'responds with success when passing a valid token' do
    get '/ping', as: :json, headers: auth_headers
    expect_status :ok
  end
end
