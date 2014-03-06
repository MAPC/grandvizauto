require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }
    it { should have_selector('a', text: '37 Billion Miles') }

    describe "when signed in" do
      before { login_with_oauth }
      it { should have_selector('button', text: 'Download'      )}
      it { should have_selector('li',     text: 'Sign Out'      )}
      it { should have_selector('li',     text: 'My Profile'    )}
      it { should have_selector('li',     text: 'Edit Profile'  )}
      it { should have_selector('li',     text: 'Welcome, Matt' )}
    end
  end

end
