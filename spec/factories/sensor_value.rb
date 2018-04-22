# frozen_string_literal: true

FactoryBot.define do
  factory :sensor_value do
    deleted 0
    sensors_id nil
    time_unix Time.now.to_i
    value { Faker::Number.number(10) }
  end
end
