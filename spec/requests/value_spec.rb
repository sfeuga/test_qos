# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sensor Value API', type: :request do
  # initialize test data
  let!(:sensor) { create(:sensor) }
  let!(:sensor_values) { create_list(:sensor_value, 10, sensor_id: sensor.id) }
  let(:sensor_id) { sensor.id }
  let(:id) { sensor_values.first.id }

  # Test suite for GET /sensors/:sensor_id/values
  describe 'GET /sensor/:sensor_id/values' do
    # make HTTP get request before each example
    before { get "/sensor/#{sensor_id}/values" }

    context 'when sensor exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns sensor values' do
        # Note `json` is a custom helper to parse JSON responses
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
      end
    end

    context 'when sensor does not exist' do
      let(:sensor_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Sensor/)
      end
    end
  end

  # Test suite for GET /sensor/:sensor_id/values/:id
  describe 'GET /sensor/:sensor_id/values/:id' do
    before { get "/sensor/#{sensor_id}/values/#{id}" }

    context 'when sensor exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the value' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(id)
      end
    end

    context 'when the sensor value does not exists' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find SensorValue/)
      end
    end
  end

  # Test suite for POST /sensor/:sensor_id/values
  describe 'POST /sensor/:sensor_id/values' do
    let(:valid_attributes) { { value: '42', done: false } }

    context 'when request attributes are valid' do
      before { post "/sensor/#{sensor_id}/values", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/sensor/#{sensor_id}/values", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Value can't be blank/)
      end
    end
  end

  # Test suite for PUT /sensor/:sensor_id/values/:id
  describe 'PUT /sensor/:sensor_id/values/:id' do
    let(:valid_attributes) { { value: '24' } }

    before { put "/sensor/#{sensor_id}/values/#{id}", params: valid_attributes }

    context 'when value exists' do
      it 'updates the record' do
        updated_item = SensorValue.find(id)
        expect(updated_item.value).to match(24)
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when the value does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find SensorValue/)
      end
    end
  end

  # Test suite for DELETE /sensor/:sensor_id/values/:id
  describe 'DELETE /sensor/:sensor_id/values/:id' do
    before { delete "/sensor/#{sensor_id}/values/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
