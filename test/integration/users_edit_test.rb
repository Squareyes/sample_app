require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
 
  def setup
    @user = users(:example)
  end

  test "succesful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = 'Example User'
    email = "example@example.com"
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password: "",
                                              password_confirmation: "" }}

    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end

  test "unsuccesful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "",
                                              email: "foo@invalid",
                                              password: "foo",
                                              password_confirmation: "bar" }}

    assert_template 'users/edit'
  end

end
