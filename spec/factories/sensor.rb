# frozen_string_literal: true

FactoryBot.define do
  factory :sensor do
    deleted 0
    name { Faker::Lorem.word }
  end
end
