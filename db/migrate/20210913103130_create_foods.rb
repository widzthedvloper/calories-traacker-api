class CreateFoods < ActiveRecord::Migration[6.1]
  def change
    create_table :foods do |t|
      t.string :name
      t.string :created_by

      t.timestamps
    end
  end
end
