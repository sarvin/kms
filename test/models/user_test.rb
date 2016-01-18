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

    assert user.name == "#{name_first} #{name_last}".titleize
  end
end
