class SubmissionsController < ApplicationController
  before_filter :signed_in_user, except: [:index, :show]
  before_filter :correct_user,   only:   [:edit,  :update]


  def index
    @submissions = Submission.page params[:page]
  end


  def show
    @submission = Submission.find params[:id]
    if signed_in?
      @rating     = Rating.where(user_id: current_user.id, submission_id: @submission.id).first || Rating.new(user: current_user, submission: @submission, score: 0)
    end
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
    @submission.user = current_user

    if @submission.save
      flash[:notice] = "Your entry will be viewable once we review & approve it, within three days. Add an email to your user profile to be notified of approval/rejection."
      redirect_to user_path(current_user)
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
      redirect_to root_url, notice: "You must be signed in to submit or edit an entry." unless signed_in?
    end

    def correct_user
      @submission = Submission.find params[:id]
      # puts "@user: #{@user.name} (#{@user.id}) | current_user: #{current_user.name} (#{current_user.id})"
      redirect_to root_url, notice: "You cannot edit another user's submission." unless current_user?(@submission.user)
    end

end
