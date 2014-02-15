namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    nums      = (0..9).to_a
    few       = (1..4).to_a
    unlikely  = [true]  ; 9.times { unlikely << false }
    likely    = [false] ; 9.times { likely   << true }
    providers = ['github', 'twitter', 'facebook', 'google']

    admin = User.new(name: 'Testmatt')
    admin.provider = 'github'
    admin.uid = 2
    admin.admin = true
    admin.judge = false
    admin.save

    19.times do
      user = User.new(name: Faker::Name.first_name)
      user.provider = providers.sample
      user.uid = nums.sample(6).join
      user.judge = unlikely.sample
      
      if user.save
        puts user.name
      else
        puts user.errors.full_messages
      end

    end

    User.all.each do |user|

      few.sample.times do
        screenshot = File.new(Rails.root + "lib/fixtures/#{nums.sample}.png")

        sub = user.submissions.create(title: Faker::Company.catch_phrase,
                                description: Faker::Lorem.sentences(2).join(" "),
                                screenshot: screenshot,
                                url: Faker::Internet.url,
                                agreed: true)
        puts sub.title

      end
    end

    Submission.all.each do |entry|
      nums.sample.times do
        rating = entry.ratings.create(score: few.sample + 1)
        puts "#{entry.title}: #{rating.score}"
      end
    end

  end
end