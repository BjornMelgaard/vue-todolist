module AuthMacroses
  def authenticate(user)
    visit '/'
    expect(page).to have_current_path '/auth/sign-in'
    within('form') do
      fill_in 'email', with:    user.email
      fill_in 'password', with: user.password
    end
    click_button 'Submit'
    expect(page).to have_current_path '/'
  end
end

RSpec.configure do |config|
  config.include AuthMacroses, type: :feature
end
