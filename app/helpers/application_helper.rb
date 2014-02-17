module ApplicationHelper

  def local_path_for(submission)
    submission.screenshot.path[6..-1]
  end
end
