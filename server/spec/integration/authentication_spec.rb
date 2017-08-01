describe 'Authentication:', type: :integration do
  context 'signin' do
    let!(:user) { create :user }

    before do
      visit('/account/signin')
    end

    def signin(email, password)
      require 'pry'; ::Kernel.binding.pry;
      within('form') do
        fill_in 'Email', with:    email
        fill_in 'Password', with: password
      end
      expect(page).to have_button('Submit', disabled: false)
      click_button 'Submit'
    end

    it 'when invalid' do
      signin(user.email, 'wrong')
      require 'pry'; ::Kernel.binding.pry;
      expect(page).to have_content 'Invalid signin credentials. Please try again'
    end

    it 'when valid' do
      signin(user.email, user.password)
      expect(page).to have_current_path '/'
    end
  end

  # context 'registration' do
  #   before do
  #     visit '/'
  #     click_on 'Sign Up'
  #     expect(page).to have_current_path '/auth/sign-up'
  #   end
  #
  #   it 'when valid' do
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
  #   it 'email already taken', user_exists: true do
  #     within('form') do
  #       fill_in 'email', with:    user.email
  #       fill_in 'password', with: user.password
  #     end
  #     click_button 'Submit'
  #     expect(page).to have_content 'Email has already been taken'
  #   end
  # end
  #
  # it 'reset password flow', user_exists: true do
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

