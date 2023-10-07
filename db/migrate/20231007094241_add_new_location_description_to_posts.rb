class AddNewLocationDescriptionToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :new_location_description, :text
  end
end