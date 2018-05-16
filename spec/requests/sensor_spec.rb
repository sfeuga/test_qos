# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sensors API', type: :request do
  # initialize test data
  let!(:sensors) { create_list(:sensor, 10) }
  let(:sensor_id) { sensors.first.id }

  # Test suite for GET /sensors
  describe 'GET /sensors' do
    # make HTTP get request before each example
    before { get '/sensors' }
    it 'returns sensors' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /sensors/:id
  describe 'GET /sensors/:id' do
    before { get "/sensors/#{sensor_id}" }

    context 'when the record exists' do
      it 'returns the sensor' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(sensor_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:sensor_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Sensor/)
      end
    end
  end

  # Test suite for POST /sensors
  describe 'POST /sensors' do
    # valid payload
    let(:valid_attributes) { { name: 'Wonderful Sensor' } }

    context 'when the request is valid' do
      before { post '/sensors', params: valid_attributes }

      it 'creates a sensor' do
        expect(json['name']).to eq('Wonderful Sensor')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/sensors', params: { name: '' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /sensors/:id
  describe 'PUT /sensors/:id' do
    let(:valid_attributes) { { name: 'This is the best Sensor Ever !' } }

    context 'when the record exists' do
      before { put "/sensors/#{sensor_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /sensors/:id
  describe 'DELETE /sensors/:id' do
    before { delete "/sensors/#{sensor_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
