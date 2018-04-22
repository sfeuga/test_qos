# frozen_string_literal: true

##
# Sensor Model
#   One sensor may have multiple sensor values
#
class Sensor < ApplicationRecord
  has_many :sensor_values

  validates :name, length: { maximum: 30 }, presence: true

  validates_presence_of :deleted, :name
end
