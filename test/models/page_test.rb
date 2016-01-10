require 'test_helper'

class PageTest < ActiveSupport::TestCase
  test "orphaned Page objects are not pageable" do
    pages = Page.orphaned

    pages.each do |page|
      assert page.pageable.nil? == true, "Page should not be associated with another object  #{page.inspect}"
    end
  end
end
