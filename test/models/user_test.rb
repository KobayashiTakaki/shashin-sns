require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User")
  end

  test "name should not be too long" do
    @user.name = "a" * 21
    assert_not @user.valid?
  end
end
