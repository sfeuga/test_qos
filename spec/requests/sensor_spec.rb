# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sensor API', type: :request do
  # initialize test data
  let!(:sensors) { create_list(:sensor, 10) }
  let(:sensor_id) { sensors.first.id }

  # Test suite for GET /sensor
  describe 'GET /sensor' do
    # make HTTP get request before each example
    before { get '/sensor' }
    it 'returns sensors' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /sensor/:id
  describe 'GET /sensor/:id' do
    before { get "/sensor/#{sensor_id}" }

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

  # Test suite for POST /sensor
  describe 'POST /sensor' do
    # valid payload
    let(:valid_attributes) { { name: 'Wonderful Sensor' } }

    context 'when the request is valid' do
      before { post '/sensor', params: valid_attributes }

      it 'creates a sensor' do
        expect(json['name']).to eq('Wonderful Sensor')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/sensor', params: { name: '' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /sensor/:id
  describe 'PUT /sensor/:id' do
    let(:valid_attributes) { { name: 'This is the best Sensor Ever !' } }

    context 'when the record exists' do
      before { put "/sensor/#{sensor_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /sensor/:id
  describe 'DELETE /sensor/:id' do
    before { delete "/sensor/#{sensor_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
