module ApplicationHelper

  def local_path_for(submission)
    submission.screenshot.path
  end
end
