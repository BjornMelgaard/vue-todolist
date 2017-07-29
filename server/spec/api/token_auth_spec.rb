require 'rails_helper'

RSpec.describe 'Token auth: ', type: :request do
  context 'registered user' do
    let(:user_attrs) do
      {
        email: Faker::Internet.email,
        password: 'secret123',
        password_confirmation: 'secret123',
        confirm_success_url: Faker::Internet.url
      }
    end

    before do
      post '/api/edge/auth', params: user_attrs, as: :json
      expect(response).to be_success
      @last_response_auth_headers = response.headers.slice('uid', 'client', 'access-token')
    end

    it 'can validate token' do
      get '/api/edge/auth/validate_token', headers: @last_response_auth_headers, as: :json
      expect(response).to be_success
    end
  end
end
