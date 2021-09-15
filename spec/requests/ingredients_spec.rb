require 'rails_helper'

  def json
    JSON.parse(response.body)
  end

RSpec.describe "Ingredients", type: :request do
  # Initialize the test data
  let!(:food) { create(:food) }
  let!(:ingredients) { create_list(:ingredient, 20, food_id: food.id) }
  let(:food_id) { food.id }
  let(:id) { ingredients.first.id }

  describe "GET /foods/:food_id/ingredients" do
    before { get "/foods/#{food_id}/ingredients"}

    context "when food exists" do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)  
      end

      it 'returns all food ingredients' do
        expect(json.size).to eq(20)
      end
    end

    context "when food does not exist" do
      let(:todo_id) { 0 }
      
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response).to match(/Couldn't find Food/)
      end
    end
  end

  describe "GET /foods/:food_id/ingredients/:id" do
    before { get "get /foods/#{food_id}/ingredients/#{id}" }

    context "when food ingredient exists" do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)  
      end

      it 'returns the ingredient' do
        expect(json['id']).to eq(id)
      end
    end
    
    context "when food ingredient does not exist" do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)  
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Coudn't find Item/)  
      end
    end
  end

  describe "POST /foods/:food_id/ingredients" do
    let(:valid_attributes) { {name: "tomato", calorie: 100 } }

    context "when request attributes are valid" do
      before { post "/foods/#{food_id}/ingredients", params: valid_attributes }

      it "returns status code 201" do
       expect(response).to have_http_status(201) 
      end
    end
    
    context "when request is invalid" do
      before { post "/foods/#{food_id}/ingredients", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422) 
      end

      it 'returns a faillure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)  
      end
    end
  end
  
  describe "PUT /foods/:food_id/ingredients/:id" do
    let(:valid_attributes) { {name: 'tomato', calorie: 100 } }
    before { put "/foods/#{food_id}/ingredients/#{id}"}
    
    context "when item exists" do
      it 'returns status code 204' do
        expect(response).to have_http_status(204) 
      end

      it 'updates the item' do
       updated_item = Ingredient.find(id)
       expect(updated_item.name).to match(/tomato/) 
      end
    end
    
    context "when ingredient does not exist" do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404) 
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Ingredient/) 
      end
    end
  end

  describe "DELETE /foods/:id" do
    before { delete "/foods/#{food_id}/ingredients/#{id}"}

    it 'returns status code 204' do
      expect(response).to have_http_status(204)  
    end
  end
  
end
