require 'spec_helper'

describe Rating do

  before { @rating = Rating.new(score: 4) }

  subject { @rating }

  it { should respond_to :score }
  it { should respond_to :user }
  it { should respond_to :submission }

  it { should be_valid }

  describe "score is blank" do

    before { @rating.score = " " }

    it { should_not be_valid }
    
  end

  describe "score is too high" do
    before { @rating.score = 6 }
    it { should_not be_valid }
  end

  describe "score is too low" do
    before { @rating.score = -1 }
    it { should_not be_valid }
  end 
end
