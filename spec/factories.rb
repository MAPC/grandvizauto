FactoryGirl.define do
  factory :submission do
    approved true
    sequence(:description) { Faker::Lorem.sentences(5).join(" ") }
    agreed true
    sequence(:title) { Faker::Company.catch_phrase }
    sequence(:url)   { Faker::Internet.url }
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