FactoryGirl.define do
  factory :wiki do
    title { Faker::HarryPotter.character }
    body { Faker::HarryPotter.quote }
    user
  end

end