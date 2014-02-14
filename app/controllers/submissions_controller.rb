class SubmissionsController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create, :edit, :update]


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


  def create
    @submission = Submission.new(params[:submission])

    if @submission.save
      flash[:notice] = "Saved successfully."
      redirect_to submission_path(@submission)
    else
      flash[:error] = "Invalid submission. Check errors."
      render 'new'
    end
  end

  private

    def signed_in_user
      redirect_to root_url, notice: "You must be signed in to submit or edit a submission." unless signed_in?
    end

end
