class Ingredient < ApplicationRecord
  belongs_to :food

  validates_presence_of :name
  validates_presence_of :calorie
end
