class AddScreenshotToSubmissions < ActiveRecord::Migration
  def change
    add_attachment :submissions, :screenshot
  end
end
