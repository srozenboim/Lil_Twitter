class Post < ActiveRecord::Base
  belongs_to :user
  validates :body, length: {maximum:140}

  def retweet(post)
    self.retweet = post.id
  end
end

