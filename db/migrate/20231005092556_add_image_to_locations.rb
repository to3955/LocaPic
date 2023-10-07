class AddImageToLocations < ActiveRecord::Migration[6.1]
  def change
    add_column :locations, :image, :string
  end
end
