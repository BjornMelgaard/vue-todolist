module Pages
  class LoginPage < SitePrism::Page
    set_url '/account/login'

    element :login, '#login-id'
    element :password, '#password-id'
    element :submit, '.login-form--submit'

    load_validation do
      require 'pry'; ::Kernel.binding.pry;
      has_login? && has_password? && has_submit?
    end

    def login_to_default_page
      submit.click
      ProjectsPage.new
    end
  end
end