class Post < ActiveRecord::Base
  belongs_to :user
  validates :body, length: {maximum:140}

  def retweet_post(post_id)
    self.retweet = post_id
  end

  def retweeted_from
    User.find(Post.find(self.retweet).user_id)
  end
end

