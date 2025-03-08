# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    password { 'Password_001' }
    full_name { Faker::Name.name }
    sequence(:email) { |n| "user#{n}@email.com" }
  end
end
