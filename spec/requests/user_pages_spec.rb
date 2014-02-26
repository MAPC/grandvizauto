require 'spec_helper'

describe "User pages" do
  
  let(:user) { FactoryGirl.create(:user) }
  before do
    visit root_path
    sign_in user
  end

  subject { page }

  pending "user edit page" do
    before do
      save_and_open_page
      visit edit_user_path(user)
    end

    it { should have_selector('label', text: 'Name') }
    it { should have_selector('label', text: 'Email') }

    describe "filling with invalid information" do
      before do
        fill_in 'Name',  with: ''
        fill_in 'Email', with: 'loyd'
        click_button 'Update'
      end
      it { should have_content 'invalid' }
    end

    describe "filling with invalid information" do
      before do
        fill_in 'Name',  with: 'Cloyd'
        fill_in 'Email', with: 'matt@mapc.com'
        click_button 'Update'
      end
      it { should have_content 'updated' }
    end
  end

  describe "user show page" do

    before { visit user_path(user) }
    
    before(:all) { 5.times { FactoryGirl.create(:submission, user: user) } }
    after(:all)  { Submission.delete_all }

    it "should list each submission" do
      user.submissions.each do |submission|
        page.should have_selector('li', text: submission.title)
      end
    end

    it { should have_content user.name }

  end

  describe "other user's pages" do
    let(:next_user) { FactoryGirl.create(:user, name: "Mert") }

    describe "profile" do
      before { visit user_path(next_user) }
      it { should have_content next_user.name }
    end

    describe "edit" do
      before { visit edit_user_path(next_user) }
      it { should_not have_content next_user.name }
      it { should have_content 'cannot edit' }
    end

    describe "submitting a PUT request to the Users#update action" do
      before { put user_path(next_user) }
      specify { response.should redirect_to(root_url) }
    end
  end

end
