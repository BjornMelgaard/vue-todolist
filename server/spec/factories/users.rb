require 'faker'

FactoryGirl.define do
  password = Faker::Internet.password
  timestamp = DateTime.parse(2.weeks.ago.to_s).to_time.strftime('%F %T')

  factory :user do
    email                 { Faker::Internet.email }
    provider              'email'
    created_at            { timestamp }
    updated_at            { timestamp }
    password              { password }
    password_confirmation { password }
  end
end
