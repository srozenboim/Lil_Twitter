class AddRetweetColumnToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :retweet, :integer
  end
  # retweet is the id of the original post
end
