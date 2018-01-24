require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:example)
    @other_user = users(:example2)
  end
  # test "micropost interface" do
  #   log_in_as(@user)
  #   get root_path
  #   assert_select 'div.pagination'
  #   assert_select 'input[type=hidden]'
  #   # Invalid submission
  #   post microposts_path, micropost: { content: "" }
  #   assert_select 'div#error_explanation'
  #   # Valid submission
  #   content = "This micropost really ties the room together"
  #   picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
  #   assert_difference 'Micropost.count', 1 do
  #     post microposts_path, micropost: { content: content, picture: picture }
  #   end
  #   assert microposts.picture?
  #   follow_redirect!
  #   assert_match content, response.body

  #   # delete post
  #   assert_select 'a', text: 'delete'
  #   first_micropost = @user.microposts.paginate(page: 1).first
  #   assert_difference 'Micropost.count', -1 do
  #     delete micropost_path(first_micropost)
  #   end

  #   # visit a different user (no delete links)
  #   get user_path(users(:example2))
  #   assert_select 'a', text: 'delete', count: 0
  # end

  test "micropost sidebar count" do
    log_in_as(@user)
    get root_path
    assert_match "#{@user.microposts.count} microposts", response.body
    # User with 0 microposts
    other_user = users(:example2)
    log_in_as(other_user)
    get root_path
    assert_match "0 microposts", response.body
    other_user.microposts.create!(content: "A micropost")
    get root_path
    assert_match ActionController::Base.helpers.pluralize(other_user.microposts.count, "micropost"), response.body
  end
end
