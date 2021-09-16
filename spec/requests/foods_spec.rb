require 'rails_helper'

def json
  JSON.parse(response.body)
end

RSpec.describe 'Foods API', type: :request do
  let(:user) { create(:user) }
  let!(:foods) { create_list(:food, 10) }
  let(:food_id) { foods.first.id }
  let(:headers) { valid_headers }

  describe 'GET /foods' do
    before { get '/foods', params: {}, headers: headers }

    it 'returns foods' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'Get /foods/:id' do
    before { get "/foods/#{food_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the food' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(food_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:food_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Food/)
      end
    end
  end

  describe 'POST /foods' do
    let(:valid_attributes) { { name: 'Pasta con tomato', created_by: user.id.to_s }.to_json }

    context 'when the request is valid' do
      before { post '/foods', params: valid_attributes, headers: headers }

      it 'creates a food' do
        expect(json['name']).to eq('Pasta con tomato')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/foods', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation faillure message' do
        expect(response.body).to match(/Validation failed: Created by can't be blank/)
      end
    end
  end

  describe 'PUT /foods/:id' do
    let(:valid_attributes) { { name: 'Pasta' } }

    context 'when the record exist' do
      before { put "/foods/#{food_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /foods/:id' do
    before { delete "/foods/#{food_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
