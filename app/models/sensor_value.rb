# frozen_string_literal: true

##
# SensorValue Model
#   One sensor value belongs to one sensor
#
class SensorValue < ApplicationRecord
  belongs_to :sensors

  validates :sensors, presence: true
  validates :time_unix, presence: true
  validates :value, presence: true

  validates_presence_of :deleted, :sensors_id, :time_unix, :value
end
