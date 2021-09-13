class Food < ApplicationRecord
  has_many :ingredients, dependent: :destroy
  validates_presence_of :name, :created_by
end
