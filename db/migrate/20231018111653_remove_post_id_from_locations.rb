class RemovePostIdFromLocations < ActiveRecord::Migration[6.1]
  def change
    remove_column :locations, :post_id, :integer
  end
end
