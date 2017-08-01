module Pages
  class SigninPage < SitePrism::Page
    set_url '/account/signin'

    section :form, 'form' do
      element :email, 'input'
      element :password, 'input'
      element :submit, 'button'
    end
  end
end
