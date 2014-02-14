require 'spec_helper'

describe "Submission pages" do

  subject { page }

  describe "single submission page" do
    
    let!(:previous)   { FactoryGirl.create(:submission, title: "The Previous Submission") }
    let!(:submission) { FactoryGirl.create(:submission) }
    let!(:next_one)   { FactoryGirl.create(:submission, title: "On to the Next One") }

    before { visit submission_path(submission) }
    
    it { should have_selector('h3', text: 'Submission') }
    it { should have_selector('h1', text: submission.title) }
    it { should have_content submission.description }
    it { should have_link('Next') }
    it { should have_link('Previous') }
    it { should_not have_selector('div', text: /rate/i ) }

    describe "next submission" do
      before { click_link "Next" }
      it { should have_selector('h1', text: next_one.title )}
    end

    describe "previous submission" do
      before { click_link "Previous" }
      it { should have_selector('h1', text: previous.title )}
    end

    describe "upon signing in" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in user
        visit submission_path(submission)
      end

      it { should have_selector('div', text: /rate/i ) }
    end
  end

  describe "before signing in" do
    describe "try to get to new submission page" do
      before { visit new_submission_path }
      it { should have_content('must be signed in') }
    end

    describe "try to get to edit submission page" do
      let(:submission) { FactoryGirl.create(:submission) }
      before { visit edit_submission_path(submission) }
      it { should have_content('must be signed in') }
    end
  end

  describe "after signing in" do
    let(:user)   { FactoryGirl.create(:user) }
    let(:submit) { "Submit" }
    before { sign_in user }

    describe "new submission page" do  
      before { visit new_submission_path }
      
      it { should have_selector('h1', text: 'Submit your work!')}
      it { should have_selector('label', text: 'Title') }
      it { should have_selector('label', text: 'Description') }
      it { should have_selector('label', text: 'URL') }
      it { should have_selector('label', text: 'Agree') }
    end

    describe "submitting an entry" do

      before { visit new_submission_path }

      describe "with invalid information" do
        it "should not create a submission" do
          expect { click_button submit }.not_to change(Submission, :count)
        end
      end

      describe "with otherwise valid information" do

        before do
          fill_in "Title",        with: "A Valid Title"
          fill_in "Description",  with: "This is a fairly good description of the visualization herein. Made in a day."
          fill_in "URL",          with: "http://www.thisisaurlright.net/data-viz"
          # TODO: attach file
        end

        describe "without checking the agree box" do
          it "should not create a submission" do
            expect { click_button submit }.not_to change(Submission, :count)
          end 
        end

        describe "with checking the agree box" do
          before { check 'Agree to the terms' }
          it "should create a submission" do
            expect { click_button submit }.to change(Submission, :count).by(1)
          end

          describe "after submitting" do
            before { click_button submit }
            it { should have_content "will be viewable" }
            it { should have_selector('h1', text: 'Grand Viz Auto') } # tests we've gone back to '/'
          end
        end

      end
    end

    describe "editing a submission" do
      let(:submission) { FactoryGirl.create(:submission, title: "Edit Me, I'm a Submission!") }
      before { visit edit_submission_path( submission ) }

      it { should_not have_content "Agree" }

      describe "with valid information" do
        before { fill_in "Title", with: "Surely Another Valid Title" }

        it "should not create a new submission" do
          expect { click_button submit }.not_to change(Submission, :count)
        end

        describe "redirects to submission show page" do
          before { click_button submit }
          it { should have_selector('h3', text: 'Submission') }
          it { should have_selector('h1', text: "Surely Another Valid Title") }
        end
      end
    end
    
  end


end