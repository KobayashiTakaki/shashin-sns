require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User")
    @comment = Comment.new(content: "Comment content.", user: @user)
  end

  test "content should not be too long" do
    @comment.content = "a" * 201
    assert_not @comment.valid?
  end
end
