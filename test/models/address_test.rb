require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  test "method columns_generated_by_user returns populated array" do
    assert Address.columns_generated_by_user.any?, 'Array should be populated with values'
  end

  test "method columns_generated_by_user returns only columns in class" do
    assert (Address.columns_generated_by_user - Address.column_names).empty?, 'Elements in array should only be found as columns in class'
  end

  test "method columns_generated_by_user does not returns all columns in model" do
    assert Address.columns_generated_by_user.length, 'Array should be populated with values'
    assert_operator Address.columns_generated_by_user.length, :<, Address.column_names.length, 'All columns in class should not be present'
  end
end
