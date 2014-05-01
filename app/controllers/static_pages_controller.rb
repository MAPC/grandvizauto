class StaticPagesController < ApplicationController
  def home
    @winners = Submission.winners
    @newest  = Submission.newest
    @top     = Submission.top
    @home    = true
  end

  def faq
  end

  def data_terms
    TermsMailer.data_terms_email(current_user).deliver
    respond_to do |format|
      format.js
    end
  end

  def contest_rules
    TermsMailer.contest_rules_email(current_user).deliver
    respond_to do |format|
      format.js
    end
  end

  def download
    if current_user.update_attribute(:agreed, true)
      redirect_to ENV['GVA_DATA_URL']
    else
      redirect_to root_url, notice: "Could not mark you as having accepted the terms, so refusing to download the file."
    end
  end
end
