require 'spec_helper'

describe Rating do

  before { @rating = Rating.new(score: 4) }

  subject { @rating }

  it { should respond_to :score }
  it { should respond_to :user }
  it { should respond_to :submission }

  it { should be_valid }
end
