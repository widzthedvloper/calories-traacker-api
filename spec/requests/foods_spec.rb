require 'rails_helper'

RSpec.describe 'Foods API', type: :request do
  # Initialize test data
  let!(:foods) { create_list(:food, 10) }
  let(:food_id) { foods.first.id }

  # test suite for Get /foods
  describe 'GET /foods' do
    # make an http request before for each example
    before { get '/foods' }

    it 'returns foods' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # test suite for GET /foods/:id
  describe 'Get /todos/:id' do
    before { get "/todos/#{todo_id}" }

    context 'when the record exists' do
      it 'returns the food' do
        expect(json).no_to be_empty
        expect(json['id']).to eq(todo_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:todo_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Food/)
      end
    end
  end

  # test suite for post /foods
  describe 'POST /foods' do
    let(:valid_attributes) { { name: 'Pasta con tomato', created_by: '1' } }

    context 'when the request is valid' do
      before { post '/foods', params: valid_attributes }

      it 'creates a food' do
        expect(json['title']).to eq('Lean Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/foods', params: { name: 'Burger' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation faillure message' do
        expect(response.body).to match(/Validation failed: Created by can't be blank/)
      end
    end
  end

  # Test suite for PUT /foods/:id
  describe 'PUT /foods/:id' do
    let(:valid_attributes) { { name: 'Pasta' } }

    context 'when the record exist' do
      before { put "/todos/#{todo_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /foods/:id
  describe 'DELETE /todos/:id' do
    before { delete "/foods/#{todo_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
