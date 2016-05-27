require 'spec_helper'

describe User, type: :model do
  let(:user) { User.create(username: 'username', email: 'someone@mail.com', password: '1234') }
  let(:user2) { User.create(username: 'username2', email: 'someone2@mail.com', password: '1234') }
  let!(:post1) { Post.create(body: 'first post', user_id: user.id) }
  let!(:post2) { Post.create(body: 'second post', user_id: user2.id) }
  let!(:post3) { Post.create(body: 'third post', user_id: user.id) }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_hash) }
  it { should have_many(:posts) }
  it { should have_many(:active) }
  it { should have_many(:passive) }
  it { should have_many(:followers) }
  it { should have_many(:following) }

  it 'should set the correct follower' do
    user.follow(user2)

    expect(user.following).to include user2
    expect(user2.followers).to include user
  end

  it 'returns the posts in the correct order' do
    user.follow(user2)
    expect(user.feed).to eq([post3, post2, post1])
  end
end
