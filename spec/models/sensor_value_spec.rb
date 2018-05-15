# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SensorValue, 'validation' do
  it { should validate_presence_of(:deleted) }
  it { should validate_presence_of(:sensor_id) }
  it { should validate_presence_of(:time_unix) }
  it { should validate_presence_of(:value) }
end
