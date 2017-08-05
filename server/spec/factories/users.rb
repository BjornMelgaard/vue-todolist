require 'faker'

FactoryGirl.define do
  factory :user do
    skip_create

    id { SecureRandom.random_number(1_000_000_000).to_s }
  end
end
