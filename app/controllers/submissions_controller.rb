class SubmissionsController < ApplicationController
  before_filter :signed_in_user, except: [:index,   :show  ]
  before_filter :correct_user,   only:   [:edit,    :update]
  before_filter :admin_user,     only:   [:approve, :reject, :new]


  def index
    if admin_user?
      @submissions = Submission.unscoped.page params[:page]
    else
      @submissions = Submission.page params[:page]
    end
  end


  def show
    if admin_user?
      @submission = Submission.unscoped.find params[:id] 
    else
      @submission = Submission.find params[:id]
    end
    
    if signed_in?
      @rating = Rating.unscoped.where(user_id: current_user.id, submission_id: @submission.id).first || Rating.create(user: current_user, submission: @submission, score: 0)
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
      flash[:success] = "Your entry will be viewable once we review & approve it, within three days. Add an email to your user profile to be notified of approval/rejection."
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
      flash[:success] = "You edited your submission #{@submission.title}."
      redirect_to submission_path(@submission)
    else
      flash[:error] = "Invalid edits. Check errors."
      render 'new'
    end
  end

  def destroy
    Submission.find(params[:id]).destroy
    flash[:success] = "Deleted submission."
    redirect_to current_user
  end

  def approve
    @submission = Submission.unscoped.find params[:id]
    if @submission.update_attribute(:approved, true)
      TermsMailer.moderate_email(@submission).deliver
      respond_to do |format|
        format.js
      end
    end
  end

  def reject
    @submission = Submission.find params[:id]
    if @submission.update_attribute(:approved, false)
      TermsMailer.moderate_email(@submission).deliver
      respond_to do |format|
        format.js
      end
    end
  end

  private

    def signed_in_user
      redirect_to root_url, notice: "You must be signed in to submit or edit an entry." unless signed_in?
    end

    def correct_user
      @submission = Submission.find params[:id]
      redirect_to root_url, notice: "You cannot edit another user's submission." unless current_user?(@submission.user)
    end

    def admin_user
      redirect_to root_url, notice: "Only admin users can moderate." unless signed_in? && admin_user?
    end

end
