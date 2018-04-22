# frozen_string_literal: true

##
# CreateSensorValues class used to migrate database
#
class CreateSensorValues < ActiveRecord::Migration[5.2]
  def change
    create_table :sensor_values do |t|
      t.integer :deleted, default: 0
      t.references :sensors, foreign_key: true, null: false
      t.integer :time_unix, null: false
      t.integer :value, null: false

      t.timestamps
    end
  end
end
