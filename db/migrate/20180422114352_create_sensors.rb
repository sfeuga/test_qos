# frozen_string_literal: true

##
# CreateSensors class used to migrate database
#
class CreateSensors < ActiveRecord::Migration[5.2]
  def change
    create_table :sensors do |t|
      t.integer :deleted, default: 0
      t.string :name, limit: 30, null: false

      t.timestamps
    end
  end
end
