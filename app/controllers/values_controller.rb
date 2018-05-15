# frozen_string_literal: true

##
# SensorValueController class
#
class ValuesController < ApplicationController
  before_action :set_sensor
  before_action :set_sensor_value, only: %i[show update destroy]

  # GET /sensor/:sensor_id/values
  def index
    @sensor_values = if params[:deleted] == 'true'
                       @sensor.sensor_values.deleted
                     else
                       @sensor.sensor_values.find_all.reject { |value| value[:deleted] == 1 }
                     end

    if @sensor_values.any?
      json_response(@sensor_values)
    else
      not_found
    end
  end

  # GET /sensor/:sensor_id/values/:id
  def show
    json_response(@sensor_value)
  end

  # POST /sensor/:sensor_id/values
  def create
    @sensor_value = @sensor.sensor_values.create!(value_params)

    json_response(@sensor_value, :created)
  end

  # PUT /sensor/:sensor_id/values/:id
  def update
    @sensor_value = SensorValue.update(value_params)

    head :no_content
  end

  # DELETE /sensor/:sensor_id/values/:id
  def destroy
    @sensor_value.destroy

    head :no_content
  end

  private

  def value_params
    params.permit(:value, :sensor_id, :deleted)
  end

  def set_sensor
    @sensor = Sensor.find(params[:sensor_id])
  end

  def set_sensor_value
    @sensor_value = @sensor.sensor_values.find_by!(id: params[:id]) if @sensor
  end
end
