class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations do |t|
      t.integer :post_id, null: false
      t.text :place_name, null: false
      t.text :address, null: false
      t.string :latitude, null: false
      t.string :longitude, null: false

      t.timestamps
    end
  end
end
