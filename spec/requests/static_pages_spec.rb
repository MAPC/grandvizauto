require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }
    it { should have_selector('h1', text: 'Grand Viz Auto') }

    pending "when signed in" do
      # before { sign_in user }
      it { should have_selector('button', 'Download')}
    end
  end

  describe "Data page" do
    before { visit '/data' }
    it { should have_selector('h1', text: 'About the data') }
  end

  describe "Challenge page" do
    before { visit '/challenge' }
    it { should have_selector('h1', text: 'About the challenge') }
  end

end
