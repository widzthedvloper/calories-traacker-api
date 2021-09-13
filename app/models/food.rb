class Food < ApplicationRecord
  has_may :ingredients, dependent: :destroy
  validates_presence_of :name, :created_by
end
