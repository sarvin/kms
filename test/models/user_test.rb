require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "scoped query orphaned returnes users not associated with chapter" do
    users = User.orphaned

    users.each do |user|
      assert_not user.chapter_id?, 'User.orphaned should only return users not associated with a chapter'
    end
  end
end
