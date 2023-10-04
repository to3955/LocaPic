class CreateSearchHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :search_histories do |t|
      t.string :term
      t.integer :user_id

      t.timestamps
    end
  end
end
