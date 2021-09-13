require 'rails_helper'

RSpec.describe Food, type: :model do
  # the model should have a 1 to many relationship
  it { should have_many(:ingredients).dependent(:destroy) }

  # ensure the name and the author of the food is present
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:created_by) }
end
