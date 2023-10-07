class AddNewLocationNameToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :new_location_name, :string
  end
end