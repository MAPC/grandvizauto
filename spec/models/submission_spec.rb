require 'spec_helper'

describe Submission do
  
  before { @submission = Submission.new(title: "An Innovative Way of looking at Debt",
                                        description: "it ain't b/c i'm ugly, because i couldn't rise, couldn't start a company, make money, couldn't make it. but because i want to dismantle it.",
                                        url: "http://agoodsite.net",
                                        screenshot: mock_file,
                                        agreed: true,
                                        user: FactoryGirl.create(:user) ) }

  subject { @submission }

  it { should respond_to :approved }
  it { should respond_to :description }
  it { should respond_to :agreed }
  it { should respond_to :agreed? }
  it { should respond_to :title }
  it { should respond_to :url }

  it { should respond_to :average_rating }
  it { should respond_to :average_user_rating }
  it { should respond_to :average_judge_rating }

  it { should respond_to :file }
  it { should respond_to :screenshot }

  it { should respond_to :user }

  it { should be_valid }

  describe "title is blank" do
    before { @submission.title = " " }
    it { should_not be_valid }
  end

  describe "title is too long" do
    before { @submission.title = "a" * 141 }
    it { should_not be_valid }
  end

  describe "title is too short" do
    before { @submission.title = "a" * 2 }
    it { should_not be_valid }
  end

  describe "description is blank" do
    before { @submission.description = " " }
    it { should_not be_valid }
  end

  describe "description is too long" do
    before { @submission.description = "a" * 1501 }
    it { should_not be_valid }
  end

  describe "description is too short" do
    before { @submission.description = "a" * 59 }
    it { should_not be_valid }
  end

  describe "description is just at minimum" do
    before { @submission.description = "a" * 60 }
    it { should be_valid }
  end

  describe "url is too long" do
    before { @submission.url = "a" * 256 }
    it { should_not be_valid }
  end

  describe "url is too short" do
    before { @submission.url = "a" * 6 }
    it { should_not be_valid }
  end

  describe "didn't agree to the terms" do
    before { @submission.agreed = false }
    it { should_not be_valid }
  end

  describe "without a user" do
    before { @submission.user = nil }
    it { should_not be_valid }
  end

  describe "must have one of URL or file" do

    describe "without a file and without a url" do
      before { @submission.url  = nil }
      it { should_not be_valid }
    end

    describe "without a file but with a url" do
      before { @submission.file = nil }
      it { should be_valid }
    end

    describe "with a file but without a url" do
      before do
        @submission.url  = nil
        @submission.file = mock_file
      end
      it { should be_valid }
    end
  end

  describe "without a screenshot" do
    before { @submission.screenshot = nil }
    it { should_not be_valid }
  end

  describe "next and previous" do
    
    before { @submission.save }

    let!(:second) { FactoryGirl.create(:submission, user: FactoryGirl.create(:user) ) }
    let!(:third)  { FactoryGirl.create(:submission, user: FactoryGirl.create(:user) ) }
    
    describe "skip blank ids" do
      before { second.destroy }

      it "has a gap between its id and the third submission" do
        ( @submission.id - third.id ).abs > 1
      end

      describe "#next" do
        it "returns the third submission" do
          @submission.next.should == third
        end
      end

      describe "#prev" do
        it "is previous to the third submission" do
          third.prev.should == @submission
        end
      end

      describe "#previous" do
        it "is previous to the third submission" do
          third.previous.should == @submission
        end
      end
    end
  end

  pending "rating methods" do

    let(:user)   { FactoryGirl.create(:user) }
    let(:user2)  { FactoryGirl.create(:user, name: "George") }
    let(:judge)  { FactoryGirl.create(:user, judge: true, name: "Reinhold") }
    let(:judge2) { FactoryGirl.create(:user, judge: true, name: "Judy") }
    let(:raters) { [user, user2, judge, judge2] }
    
    before do
      raters.each do |rater|
        rating = @submission.ratings.build(score: (0..5).to_a.sample)
        rating.user = rater
        rating.save ; rating.reload
      end
    end

    pending "#average_rating" do
    end

    pending "#average_user_rating" do
    end

    pending "#average_judge_rating" do
    end
  end



end
