class IngredientsController < ApplicationController
    before_action :set_food
    before_action :set_food_ingredient, only: [:show, :update, :destroy]

    def index
      json_response(@food.ingredients)
    end

    def show
      json_response(@food)
    end

    def create
      @food.ingredients.create!(ingredient_params)
      json_response(@food, :created)
    end

    def update
      @ingredient.update(ingredient_params)
      head :no_content
    end

    def destroy
      @ingredient.destroy
      head :no_content
    end

    private

    def ingredient_params
      params.permit(:name, :calorie)
    end

    def set_food
      @food = Food.find(params[:food_id])
    end

    def set_food_ingredient
      @ingredient = @food.ingredients.find_by!(id: params[:id]) if @food
    end
end
