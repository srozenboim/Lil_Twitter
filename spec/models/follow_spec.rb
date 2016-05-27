require 'spec_helper'

describe Follow, type: :model do
  it { should belong_to :follower }
  it { should belong_to :followed }
end
