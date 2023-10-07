class AddGeolocationToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :latitude, :string
    add_column :posts, :longitude, :string
  end
end
