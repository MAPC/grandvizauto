require 'spec_helper'

describe Submission do
  
  before { @submission = Submission.new() }

  subject { @submission }

  it { should respond_to :approved }
  it { should respond_to :description }
  it { should respond_to :rules }
  it { should respond_to :title }
  it { should respond_to :url }

  it { should be_valid }
end
