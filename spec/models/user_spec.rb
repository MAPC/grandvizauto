require 'spec_helper'

describe User do
  
  before { @user = User.new(name: "Matt") }

  subject { @user }

  it { should respond_to :name }
  it { should respond_to :ratings }
  it { should respond_to :submissions }

  it { should respond_to :admin }
  it { should respond_to :judge }

  it { should respond_to :provider }
  it { should respond_to :uid }

  it { should be_valid }
end
