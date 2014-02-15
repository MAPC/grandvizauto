FactoryGirl.define do
  factory :submission do
    approved true
    description "This visualization shows the evolution of driving in Greater Boston."
    agreed true
    title "Drive/Time"
    url "http://ariofsevit.com/data-driven"
    screenshot_file_name 'test.png'
    screenshot_content_type 'image/png'
    screenshot_file_size 1024
  end
end


FactoryGirl.define do
  factory :user do
    name      "Matt"
    provider  "github"
    uid       "000001"
  end
end