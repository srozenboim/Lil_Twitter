class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :body, limit: 140
      t.integer :user_id
      t.timestamps
    end
  end
end

