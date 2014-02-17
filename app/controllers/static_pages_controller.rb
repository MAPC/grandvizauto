class StaticPagesController < ApplicationController
  def home
  end

  def data
  end

  def challenge
  end

  def download
    if current_user.update_attribute(:agreed, true)
      data = open(ENV['GVA_DATA_URL'])
      send_data data.read, type: data.content_type, x_sendfile: true
    else
      redirect_to root_url, notice: "Could not mark you as having accepted the terms, so refusing to download the file."
    end
  end
end
