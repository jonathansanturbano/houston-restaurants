class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.text :description
      t.references :user

      t.timestamps
    end
  end
end
