require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  # each record belongs to a food
  it { should belong_to(:food) }

  # the name of the ingredient and the number of calories should be present
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:calorie) }
end
