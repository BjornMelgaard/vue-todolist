RSpec.shared_context 'create_user' do
  let!(:user) { create :user }
  let(:auth_headers) { user.create_new_auth_token }
end

RSpec.configure do |rspec|
  rspec.include_context 'create_user', create_user: true
end
