require 'spec_helper'

describe "Submission pages" do

  subject { page }

  describe "single submission page" do
    
    let!(:previous)   { FactoryGirl.create(:submission, title: "The Previous Submission") }
    let!(:submission) { FactoryGirl.create(:submission) }
    let!(:next_one)   { FactoryGirl.create(:submission, title: "On to the Next One") }

    before { visit submission_path(submission) }
    
    it { should have_selector('h1', text: submission.title) }
    it { should have_content submission.description }
    it { should have_link('Next') }
    it { should have_link('Previous') }
    it { should_not have_selector('div', text: "Rate this entry!" ) }

    describe "next submission" do
      before { click_link "Next" }
      it { should have_selector('h1', text: next_one.title )}
    end

    describe "previous submission" do
      before { click_link "Previous" }
      it { should have_selector('h1', text: previous.title )}
    end

    describe "upon signing in" do
      before do
        login_with_oauth
        visit submission_path(submission)
      end
      it { should have_selector('div', text: "Rate this entry!" ) }
    end
  end

  describe "before signing in" do

    describe "cannot view new submission page" do
      before { visit new_submission_path }
      it { should have_content('must be signed in') }
    end

    describe "cannot view edit submission page" do
      let(:submission) { FactoryGirl.create(:submission) }
      before { visit edit_submission_path(submission) }
      it { should have_content('must be signed in') }
    end

  end

  describe "after signing in" do
    before { login_with_oauth }
    
    describe "can view new submission page" do  
      before { visit new_submission_path }
      
      it { should have_selector('h1',    text: 'Submit your work!')}
      it { should have_selector('label', text: 'Title') }
      it { should have_selector('label', text: 'Description') }
      it { should have_selector('label', text: 'URL') }
      it { should have_selector('label', text: 'screenshot') }
      it { should have_selector('label', text: 'Upload a file') }
      it { should have_selector('label', text: 'Agree') }
    end

    describe "submitting an entry" do

      let(:submit) { "Submit" }
      before { visit new_submission_path }

      describe "with invalid information" do
        it "should not create a submission" do
          expect { click_button submit }.not_to change(Submission, :count)
        end
      end

      describe "with almost valid information" do
        before do
          fill_in "Title",        with: "A Valid Title"
          fill_in "Description",  with: "A valid description of the visualization herein. Made in a day. Can you believe even?"
          check 'Agree to the terms'
        end
        it "should not create a submission" do
          expect { click_button submit }.not_to change(Submission, :count)
        end 
      end

      describe "with a file and no url" do
        before do
          fill_in "Title",        with: "A Very Good Title"
          fill_in "Description",  with: "This is an excellent, not just 'good' description of the visualization herein. Made in a day."
          attach_file "Attach a screenshot", mock_file.path
          attach_file "Upload a file",       mock_file.path
          check 'Agree to the terms' 
        end
        it "should create a submission" do
          expect { click_button submit }.to change(Submission, :count).by(1)
        end
      end

      describe "with valid filled-in information" do

        before do
          fill_in "Title",        with: "A Valid Title"
          fill_in "Description",  with: "This is a fairly good description of the visualization herein. Made in a day."
          fill_in "URL",          with: "http://www.thisisaurlright.net/data-viz"
          attach_file "Attach a screenshot", mock_file.path
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
            it { should have_selector('h1', text: "Matt") }
            it { should have_selector('li', text: "A Valid Title") }
          end
        end
      end # with valid filled-in information
    end # submitting an entry


    describe "editing a submission" do
      
      let!(:submission) { FactoryGirl.create(:submission, title: "Edit Me, I'm a Submission!") }
      
      before do
        puts "#{submission.inspect}"
        puts "#{edit_submission_path(submission)}"
        visit edit_submission_path(submission)
        save_and_open_page
      end

      it { should_not have_content "Agree" }

      # describe "with valid information" do
      #   before { fill_in "Title", with: "Surely Another Valid Title" }

      #   it "should not create a new submission" do
      #     expect { click_button submit }.not_to change(Submission, :count)
      #   end

      #   describe "redirects to submission show page" do
      #     before { click_button submit }
      #     it { should have_selector('h1', text: "Surely Another Valid Title") }
      #   end
      # end

      # describe "deleting links" do
      #   it { should_not have_link('Delete') }
      # end

    # describe "editing the wrong submission" do
    #   let(:wrong_user)       { FactoryGirl.create(:user, name: "Dr. Cox") }
    #   let(:wrong_submission) { FactoryGirl.create(:submission, title: "Wrong Wrong Wrong Wrong", user: wrong_user) }
    #   before { visit edit_submission_path( wrong_submission ) }
    #   it { should have_content "cannot edit another user's submission" }
    #   it { should have_selector('h1', text: "37 Billion Miles") }
    # end
    end

  end # after signing in
end

    

    
#   end


# end