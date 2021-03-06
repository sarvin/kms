require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test "should get index" do
    @user = sign_in_user(User.take)

    get :index
    assert_response :success, "Should be successfully viewing admin/users"
    assert assigns(:chapters)
  end

  test "should get new" do
    @user = sign_in_user(User.take)

    get :new
    assert_response :success, "Should be successfully viewing admin/users"
    assert assigns(:user)
    assert_select '#user_password', @user.password
  end

  test "create action should create a new user" do
    ### Arrange
    user_attributes = self.class.user_attributes

    @user = sign_in_user(User.take)

    ### Act
    post(
      :create,
      :user => user_attributes
    )

    new_user = User.find_by name_first: user_attributes[:name_first]
    assert defined?(new_user), 'User should be created'
    assert_redirected_to admin_user_path(assigns(:user)), 'should be redirected after post'
  end

  test "create action with nested address should create a new user and address" do
    ### Arrange
    user_attributes = self.class.user_attributes
    add_address_attributes(user_attributes)

    ### need a user to be signed in before reaching admin interface
    @user = sign_in_user(User.take)

    ### Act
    stuff = post(
      :create,
      :user => user_attributes
    )

    new_user = User.find_by name_first: user_attributes[:name_first]

    ### Assert
    assert defined?(new_user), 'User should be created'
    assert_equal new_user.address.line_1, user_attributes[:address_attributes][:line_1], "First line in address should equal"
    assert new_user.has_role?('prospect'), 'Prospect added to new user on creation'
    assert_equal 1, new_user.role_list.length, 'single role assigned to new user'
    assert_redirected_to admin_user_path(assigns(:user))
  end

  test "create does not add additional roles" do
    ### Arrange
    user_attributes = self.class.user_attributes
    add_address_attributes(user_attributes)
    add_role_parameters(user_attributes)

    ### need a user to be signed in before reaching admin interface
    @user = sign_in_user(User.take)

    ### Act
    stuff = post(
      :create,
      :user => user_attributes
    )

    new_user = User.find_by name_first: user_attributes[:name_first]

    ### Assert
    assert new_user.has_role?('prospect'), 'Prospect added to new user on creation'
    assert_equal 1, new_user.role_list.length, 'single role assigned to new user'
  end

  test 'update user' do
    ### Arrange
    user_attributes = {name_last: 'test_last_name'}
    add_address_attributes(user_attributes)

    ### need a user to be signed in before reaching admin interface
    @user = User.take
    @user.confirm
    sign_in :user, @user

    ### Act
    patch(
      :update,
      id: @user.id,
      user: user_attributes
    )

    user = User.find(@user.id)

    ### Assert
    assert_equal user.name_last, user_attributes[:name_last], "name_last shoudl be set to #{user_attributes[:name_last]}"
    assert_not_nil user.address, "address object not nil"
    assert_redirected_to admin_user_path(assigns(:user))
  end

  test 'update user with roles' do
    ### Arrange
    user_attributes = {name_last: 'test_last_name'}
    add_address_attributes(user_attributes)
    add_role_parameters(user_attributes)

    ### need a user to be signed in before reaching admin interface
    @user = sign_in_user(User.take)

    ### Act
    patch(
      :update,
      id: @user.id,
      user: user_attributes
    )

    user = User.find(@user.id)

    ### Assert
    assert ((user.role_list - user_attributes[:role_names]) + (user_attributes[:role_names] - user.role_list)).blank?, 'user should have roles set in add_role_parameters'
  end

  test 'show user with no address associated' do
    ### Arrange
    @user = sign_in_user(User.take)

    ### Act
    get(:show, {id: @user.id})

    ### Assert
    assert_response :success, "Should be successfully viewing admin/users"
    assert assigns(:user)
  end

  test 'show user with address associated and chapter associated with chapter' do
    ### Arrange
    ### need a user to be signed in before reaching admin interface
    @user = User.where.not(chapter_id: nil).first
    @chapter = Chapter.take
    @address = Address.new()
    @user.address= @address
    @user.save

    @user = sign_in_user(@user)

    ### Act
    get(:show, {id: @user.id})

    ### Assert
    assert_response :success, "Should be successfully viewing admin/users"
    assert assigns(:user)
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

  def address_attributes
    {
      line_1: 'first line in address',
      line_2: "",
      city: "",
      state_id: "",
      postal_code: ""
    }
  end

  def sign_in_user(user)
    user.confirm
    sign_in :user, user

    return user
  end

  def add_address_attributes(params)
    params[:address_attributes] = address_attributes
  end

  def add_role_parameters(params)
    params[:role_names] = User.available_role_names.sample(3)
  end
end
