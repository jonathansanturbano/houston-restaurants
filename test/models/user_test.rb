require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "can create new user" do
    assert_difference('User.count', 1) do
      new_user = User.new(email: "hello@example.com", password: "password", password_confirmation: "password")
      new_user.save
    end
  end

  test "cannot create another user with email of existing user" do
    assert_no_difference('User.count') do
      duplicate_email_user = User.new(email: users(:john).email, password: "password", password_confirmation: "password")
      duplicate_email_user.save
    end
  end
end
