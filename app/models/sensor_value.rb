# frozen_string_literal: true

##
# SensorValue Model
#   One sensor value belongs to one sensor
#
class SensorValue < ApplicationRecord
  belongs_to :sensors, foreign_key: 'sensor_id', class_name: 'Sensor'
  after_initialize :initialization

  validates :time_unix, presence: true
  validates :value, presence: true

  validates_presence_of :deleted, :time_unix, :value, :sensor_id

  def initialization
    self.time_unix ||= DateTime.current
  end
end
