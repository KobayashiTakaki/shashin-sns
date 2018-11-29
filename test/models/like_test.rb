require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  def setup
    @user = users(:peter)
    @post = posts(:peter_one)
    @like = Like.new(user: @user, post: @post)
  end

  test "user and post should be unique" do
    @like.save
    duplicate_like = @like.dup
    assert_not duplicate_like.valid?
  end
end
