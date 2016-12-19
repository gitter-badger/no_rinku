require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username: "Elkhan", email: "elkhan@example.com", password: "password", password_confirmation: "password")
  end

  test "has to be valid" do
    assert @user.valid?
  end

  test "has to have a username" do
    @user.username = " "
    assert_not @user.valid?
  end

  test "username should not be less than 4 characters" do
    @user.username = 'a' * 3
    assert_not @user.valid?
  end

  test "username should not be more than 50 characters" do
    @user.username = 'a' * 51
    assert_not @user.valid?
  end

  test "has to have a role" do
    assert_not_empty(@user.role)
  end

  test "password can't be blank" do
    @user.password = @user.password_confirmation = ' ' * 6
    assert_not @user.valid?
  end

  test "password has to be longer than 6 characters" do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end

end
