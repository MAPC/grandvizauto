def sign_in(user)
  visit root_path
  click_link 'Sign in'

  # Sign in when not using Capybara as well.
  post '/auth/github'
end
