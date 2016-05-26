class User < ActiveRecord::Base
	validates :username, :email, :password_hash, presence: true
	validates :email, uniqueness: true

	has_many :posts
	has_many :active, { class_name: 'Follow', foreign_key: :follower_id }
	has_many :passive, { class_name: 'Follow', foreign_key: :followed_id }
	has_many :followers, { through: :passive, source: :follower }
	has_many :following, { through: :active, source: :followed }

	def follow(other_user)
		self.following << other_user
	end

	include BCrypt

	def password
		@password ||= Password.new(password_hash)
	end

	def password=(new_password)
		@password = Password.create(new_password)
		self.password_hash = @password
	end

end
