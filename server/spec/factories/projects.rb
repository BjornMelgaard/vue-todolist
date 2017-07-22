FactoryGirl.define do
  FactoryGirl.define do
    factory :project do
      name { Faker::Lorem.sentence }
    end
  end
end
