def sign_in(user)
  visit root_path
  click_link 'Sign in with GitHub'

  # Sign in when not using Capybara as well.
  post '/auth/github'
end

def mock_file
  File.new(Rails.root + 'spec/fixtures/rails.png')
end