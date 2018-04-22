# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Sensor, 'validation' do
  it { should validate_presence_of(:deleted) }
  it { should validate_presence_of(:name) }
end

RSpec.describe Sensor, 'column_specification' do
  it { should have_db_column(:name).of_type(:string).with_options(length: { maximum: 30 }, presence: true) }
end
