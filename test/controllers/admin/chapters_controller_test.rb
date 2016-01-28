require 'test_helper'

class Admin::ChaptersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test "should get index" do
    @user = sign_in_user(User.take)

    get :index
    assert_response :success
    assert_not_nil assigns(:orphaned_chapters)
    assert_not_nil assigns(:adopted_chapters)
  end

  test "public navigation available on edit" do
    @user = sign_in_user(User.take)
    @chapter = Chapter.find_by(name:'SAMTAZ')
    get :show, id: @chapter.id
    assert_response :success
    assert_not_nil assigns(:chapter)
  end
private
  def sign_in_user(user)
    user.confirm
    sign_in :user, user

    return user
  end
end
