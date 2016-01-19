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

  test "should get new" do
    @user = User.take
    @user.confirm

    sign_in :user, @user

    get :new
    assert_response :success, "Should be successfully viewing admin/users"
    assert_not_nil assigns(:user)

    assert_select '#user_password', @user.password
  end

  test "create action should create a new user" do
    ### Arrange
    user_attributes = self.class.user_attributes

    ### need a user to be signed in before reaching admin interface
    @user = User.take
    @user.confirm
    sign_in :user, @user

    ### Act
    stuff = post(
      :create,
      :user => user_attributes
    )

    new_user = User.find_by name_first: user_attributes[:name_first]
    assert defined?(new_user), 'User should be created'
  end

  test "create action with no nested attributes should not create an address" do
    ### Arrange
    user_attributes = self.class.user_attributes

    ### need a user to be signed in before reaching admin interface
    @user = User.take
    @user.confirm
    sign_in :user, @user

    ### Act
    stuff = post(
      :create,
      :user => user_attributes
    )

    new_user = User.find_by name_first: user_attributes[:name_first]
    assert defined?(new_user), 'User should be created'
    assert_nil new_user.address, 'address should not return a persisted object'
  end

  test "create action with nested address should create a new user and address" do
    ### Arrange
    user_attributes = self.class.user_attributes
    user_attributes[:address_attributes] = self.class.address_attributes

    ### need a user to be signed in before reaching admin interface
    @user = User.take
    @user.confirm
    sign_in :user, @user

    line_1 = 'first line in address'

    ### Act
    stuff = post(
      :create,
      :user => user_attributes
    )

    new_user = User.find_by name_first: 'tim'

    assert defined?(new_user), 'User should be created'
    assert_equal new_user.address.line_1, user_attributes[:address_attributes][:line_1], "First line in address should equal #{line_1}"
  end

private

  def self.user_attributes
    chapter = Chapter.take

    {
      name_first: 'tim',
      password: '12345678',
      name_last: 'yyy',
      email: 'foo@bar.com',
      chapter_id: chapter.id,
    }
  end

  def self.address_attributes
    {
      line_1: 'first line in address',
      line_2: "",
      city: "",
      state_id: "",
      postal_code: ""
    }
  end
end
