class CreateReplies < ActiveRecord::Migration[6.1]
  def change
    create_table :replies do |t|

      t.text :comment
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end
  end
end
