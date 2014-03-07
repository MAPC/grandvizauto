class TermsMailer < ActionMailer::Base
  default from: '37billionmiles@mapc.org'

  def data_terms_email(user)
    @user = user
    mail(to: @user.email, subject: '37 Billion Miles: Data Use Agreement')
  end

  def contest_rules_email(user)
    @user = user
    mail(to: @user.email, subject: '37 Billion Miles: Contest Rules')
  end

  def confirm_email(user)
    @user = user
    mail(to: @user.email, subject: 'Confirm Your Email Address for 37 Billion Miles')
  end

  def moderate_email(submission)
    @submission = submission
    @user = @submission.user
    mail(to: @user.email, subject: "Your Submission Was Moderated")
  end
end
