# frozen_string_literal: true

##
# SensorController class
#
class SensorController < ApplicationController
  before_action :set_sensor, only: %i[show update destroy]

  # GET /sensor
  def index
    @sensors = if params[:deleted] == 'true'
                 Sensor.deleted
               else
                 Sensor.find_all
               end

    if @sensors.any?
      json_response(@sensors)
    else
      not_found
    end
  end

  # GET /sensor/:id
  def show
    json_response(@sensor)
  end

  # POST /sensor
  def create
    @sensor = Sensor.create!(sensor_params)

    json_response(@sensor, :created)
  end

  # PUT /sensor/:id
  def update
    @sensor = Sensor.update(sensor_params)

    head :no_content
  end

  # DELETE /sensor/:id
  def destroy
    @sensor.destroy

    head :no_content
  end

  private

  def sensor_params
    params.permit(:name, :deleted)
  end

  def set_sensor
    @sensor = Sensor.find(params[:id])
  end
end
