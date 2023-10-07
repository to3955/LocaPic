class AddDescriptionToLocations < ActiveRecord::Migration[6.1]
  def change
    add_column :locations, :description, :text
  end
end
