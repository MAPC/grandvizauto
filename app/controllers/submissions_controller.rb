class SubmissionsController < ApplicationController
  before_filter :signed_in_user, except: [:index, :show]


  def index
    @submissions = Submission.page params[:page]
  end


  def show
    @submission = Submission.find params[:id]
    @rating     = Rating.where(user_id: current_user.id, submission_id: @submission.id).first || Rating.create(user: current_user, submission: @submission, score: 0)
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
      flash[:notice] = "Your entry will be viewable once we review & approve it, within three days.\nAdd an email to your user profile to be notified of approval/rejection."
      redirect_to root_path
    else
      flash[:error] = "Invalid submission. Check errors."
      render 'new'
    end
  end

  def update
    @submission = Submission.find params[:id]
    @submission.update_attributes(params[:submission])

    if @submission.save
      flash[:notice] = "You edited your submission #{@submission.title}."
      redirect_to submission_path(@submission)
    else
      flash[:error] = "Invalid edits. Check errors."
      render 'new'
    end
  end

  private

    def signed_in_user
      redirect_to root_url, notice: "You must be signed in to submit or edit a submission." unless signed_in?
    end

end
