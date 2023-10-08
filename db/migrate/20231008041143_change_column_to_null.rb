class ChangeColumnToNull < ActiveRecord::Migration[6.1]
  def up
    change_column :locations, :post_id, :integer, null: true
    change_column :locations, :place_name, :text, null: true
    change_column :locations, :address, :text, null: true
    change_column :locations, :latitude, :string, null: true
    change_column :locations, :longitude, :string, null: true
  end

  def down
    change_column :locations, :post_id, :integer, null: false # もとに戻すときに null 制約を付ける必要がある場合
    change_column :locations, :place_name, :text, null: false # もとに戻すときに null 制約を付ける必要がある場合
    change_column :locations, :address, :text, null: false # もとに戻すときに null 制約を付ける必要がある場合
    change_column :locations, :latitude, :string, null: false # もとに戻すときに null 制約を付ける必要がある場合
    change_column :locations, :longitude, :string, null: false # もとに戻すときに null 制約を付ける必要がある場合
  end
end