module ApplicationHelper

  def local_path_for(submission)
    submission.screenshot.url
  end

  def download_file_link(submission)
    if submission.file && !submission.file.content_type.nil?
      content_tag :p do
        link_to "Download File [#{content_abbv(submission.file)}]", submission.file.url
      end
    end
  end

  def content_abbv(file)
    file.content_type.match(/\/(.*)$/i).captures.first.upcase unless file.content_type.nil?
  end
end
