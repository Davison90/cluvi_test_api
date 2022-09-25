FactoryBot.define do
  factory :shortener do
    url { Faker::Internet.url }
    alexa_rank { rand(1..1000) }
  end
end
