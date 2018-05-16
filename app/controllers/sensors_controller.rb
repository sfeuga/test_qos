# frozen_string_literal: true

##
# SensorController class
#
class SensorsController < ApplicationController
  before_action :set_sensor, only: %i[show update destroy]

  # GET /sensors
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

  # GET /sensors/:id
  def show
    json_response(@sensor)
  end

  # POST /sensors
  def create
    @sensor = Sensor.create!(sensor_params)

    json_response(@sensor, :created)
  end

  # PUT /sensors/:id
  def update
    @sensor = Sensor.update(sensor_params)

    head :no_content
  end

  # DELETE /sensors/:id
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
