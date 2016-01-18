require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "scoped query orphaned returnes users not associated with chapter" do
    users = User.orphaned

    users.each do |user|
      assert user.chapter_id? == false
    end
  end
end
