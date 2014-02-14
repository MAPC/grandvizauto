class SubmissionsController < ApplicationController
  def index
  end

  def show
    @submission = Submission.find params[:id]
  end

  def edit
    @submission = Submission.find params[:id]
    render 'new'
  end

  def new
    @submission = Submission.new
  end

end
