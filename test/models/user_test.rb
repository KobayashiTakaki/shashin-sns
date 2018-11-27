require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'Example',
                    email: 'email@example.com',
                    display_name: 'Example User',
                    password: "password",
                    password_confirmation: "password")
  end

  test "name should not be too long" do
    @user.name = "a" * 21
    assert_not @user.valid?
  end

  test "duplicate name and email should be invalid" do
    @user.save
    duplicate_user = @user.dup
    duplicate_user.name = @user.name
    duplicate_user.email = "hoge@example.com"
    assert_not duplicate_user.valid?
    duplicate_user.name = "hoge"
    duplicate_user.email = @user.email
    assert_not duplicate_user.valid?
    duplicate_user.name = "hoge"
    duplicate_user.email = @user.email.upcase
    assert_not duplicate_user.valid?
  end

  test "name should be case sensitive" do
    @user.save
    duplicate_user = @user.dup
    duplicate_user.name = @user.name.upcase
    duplicate_user.email = "hoge@example.com"
    assert duplicate_user.valid?
  end

end
