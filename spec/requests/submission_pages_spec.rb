require 'spec_helper'

describe "Submission pages" do

  subject { page }

  describe "single submission page" do
    let(:submission) { FactoryGirl.create(:submission) }
    before { visit submission_path(submission) }
    it { should have_selector('h3', text: 'Submission') }
    it { should have_selector('h1', text: submission.title) }
    it { should have_content submission.description }
    it { should have_link('Next') }
    it { should have_link('Previous') }
    it { should have_selector('div', text: /rate/i ) }
  end

  pending "before signing in" do
    pending "try to get to new submission page" do
      before { visit new_submission_path }
      it { should have_content('must be signed in') }
    end

    pending "try to get to edit submission page" do
      let(:submission) { FactoryGirl.create(:submission) }
      before { visit edit_submission_path(submission) }
      it { should have_content('must be signed in') }
    end
  end

  pending "after signing in" do
    # before { sign_in user } # TODO: add this test helper
    # TODO: put all following tests in this area
  end

  describe "new submission page" do
    
    before { visit new_submission_path }
    
    it { should have_selector('h1', text: 'Submit your work!')}
    it { should have_selector('label', text: 'Title') }
    it { should have_selector('label', text: 'Description') }
    it { should have_selector('label', text: 'URL') }
    it { should have_selector('label', text: 'Agree') }
  end


  pending "submitting an entry" do

    before { visit new_submission_path }

    let(:submit) { "Submit" }

    pending "with invalid information" do
      it "should not create a submission" do
        expect { click_button submit }.not_to change(Submission, :count)
      end
    end

    pending "with otherwise valid information" do

      before do
        fill_in "Title",        with: ""
        fill_in "Description",  with: ""
        fill_in "URL",          with: ""
        # TODO: attach file
      end

      pending "without checking the agree box" do
        it "should not create a submission" do
          expect { click_button submit }.not_to change(Submission, :count)
        end 
      end

      pending "with checking the agree box" do
        # TODO: before { check the agree box }
        it "should create a submission" do
          expect { click_button submit }.to change(Submission, :count).by(1)
        end
      end

    end
  end


  pending "editing a submission" do
  end
  
end