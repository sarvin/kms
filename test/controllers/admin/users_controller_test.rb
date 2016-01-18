require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test "should get index" do
    @user = User.take
    @user.confirm

    sign_in :user, @user

    get :index
    assert_response :success, "Should be successfully viewing admin/users"
    assert_not_nil assigns(:chapters)
  end
end
