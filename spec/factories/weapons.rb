FactoryBot.define do
  factory :weapon do
    name        { FFaker::Internet.user_name  }
    description { FFaker::Lorem.sentence }
    power_base  { FFaker::Random.rand(1..3000) }
    power_step  { FFaker::Random.rand(1..1000) }
    level       { FFaker::Random.rand(1..9) }
  end
end
