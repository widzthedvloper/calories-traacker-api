class FoodsController < ApplicationController
  before_action :set_food, only: %i[show update destroy]

  # GET /foods
  def index
    @foods = Food.all
    json_response(@foods)
  end

  # POST /foods
  def create
    @food = Food.create!(food_params)
    json_response(@food, :created)
  end

  # GET /foods/:id
  def show
    json_response(@food)
  end

  # PUT /foods/:id
  def update
    @food.update(food_params)
    head :no_content
  end

  # DELETE /todos/:id
  def destroy
    @food.destroy
    head :no_content
  end

  private

  def food_params
    params.permit(:name, :created_by)
  end

  def set_food
    @food = Food.find(params[:id])
  end
end
