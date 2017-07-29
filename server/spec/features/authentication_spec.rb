feature 'Authentication:' do
  context 'login' do
    let!(:user) { create :user }

    before do
      login_page = Pages::LoginPage.new
      login_page.load
    end

    scenario 'when invalid' do
      within('form') do
        fill_in 'email', with:    user.email
        fill_in 'password', with: 'wrong_password'
      end
      click_button 'Submit'
      expect(page).to have_content 'Invalid login credentials. Please try again'
    end

    scenario 'when valid' do
      within('form') do
        fill_in 'email', with:    user.email
        fill_in 'password', with: user.password
      end
      click_button 'Submit'
      expect(page).to have_current_path '/'
    end
  end
  #
  # context 'registration' do
  #   before do
  #     visit '/'
  #     click_on 'Sign Up'
  #     expect(page).to have_current_path '/auth/sign-up'
  #   end
  #
  #   scenario 'when valid' do
  #     expect do
  #       user = attributes_for :user
  #       within('form') do
  #         fill_in 'email', with:    user[:email]
  #         fill_in 'password', with: user[:password]
  #       end
  #       click_button 'Submit'
  #       expect(page).to have_current_path '/'
  #     end.to change(User, :count).by(1)
  #   end
  #
  #   scenario 'email already taken', user_exists: true do
  #     within('form') do
  #       fill_in 'email', with:    user.email
  #       fill_in 'password', with: user.password
  #     end
  #     click_button 'Submit'
  #     expect(page).to have_content 'Email has already been taken'
  #   end
  # end
  #
  # scenario 'reset password flow', user_exists: true do
  #   visit '/'
  #   click_on 'Forgot Password?'
  #   expect(page).to have_current_path '/auth/reset-password'
  #
  #   within('form') do
  #     fill_in 'email', with: user.email
  #   end
  #   click_button 'Submit'
  #
  #   expect(page).to have_content 'email has been sent'
  #   expect(page).to have_current_path '/auth/reset-password'
  #
  #   follow_reset_password_email(user.email)
  #   expect(page).to have_current_path('/auth/update-password', only_path: true)
  #
  #   new_password = 'secret123'
  #   within('form') do
  #     fill_in 'password', with: new_password
  #     fill_in 'password_confirmation', with: new_password
  #   end
  #   click_button 'Submit'
  #   expect(page).to have_content 'Password was successfully updated'
  # end
end
