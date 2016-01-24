require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "scoped query orphaned returnes users not associated with chapter" do
    users = User.orphaned

    users.each do |user|
      assert_not user.chapter_id?, 'User.orphaned should only return users not associated with a chapter'
    end
  end

  test "name instance method returns titleized first and last name" do
    name_first = 'xxx'
    name_last = 'yyy'
    user = User.new(name_first: name_first, name_last: name_last)

    assert_equal "#{name_first} #{name_last}".titleize, user.name
  end

  test "set_default_role should set user as prospect by default" do
    ### Arrange
    user = User.new(name_first: 'Izzy', name_last: 'Isdizzy')

    ### Act
    active_record_proxy_collection = user.send(:set_default_role)
    roles = active_record_proxy_collection.select{|x| x.class.name === 'Royce::Role' and x.name === 'prospect'}

    ### Assert
    assert_equal 1, roles.length, 'One Royce::Role should be prospect'
  end
end
