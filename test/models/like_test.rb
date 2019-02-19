require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  def setup
    @user = users(:peter)
    @article = articles(:peter_one)
    @like = Like.new(user: @user, article: @article)
  end

  test "user and article should be unique" do
    @like.save
    duplicate_like = @like.dup
    assert_not duplicate_like.valid?
  end
end
