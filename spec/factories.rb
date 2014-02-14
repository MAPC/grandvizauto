FactoryGirl.define do
  factory :submission do
    approved true
    description "This visualization shows the evolution of driving in Greater Boston."
    agreed true
    title "Drive/Time"
    url "http://ariofsevit.com/data-driven"
  end
end


FactoryGirl.define do
  factory :user do
    name      "Matt"
    provider  "github"
    uid       "000001"
  end
end