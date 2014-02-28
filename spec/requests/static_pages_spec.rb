require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }
    it { should have_selector('h1', text: '37 Billion Miles') }

    describe "when signed in" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }
      it { should have_selector('button', 'Download')}
    end
  end

end
