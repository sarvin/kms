require 'test_helper'
 
class HomeHelperTest < ActionView::TestCase
  include HomeHelper
 
  test "should return array containing Chapter, State and Page objects" do
		menu_items = get_menu_items

		assert menu_items.map{|menu_item| menu_item.class.name}.uniq.sort.join() == 'ChapterPageState'
  end

  test "first element in sorted menu items should be home page" do
		menu_items = get_menu_items

		ordered_menu_items = order_menu_items(menu_items)

		assert ordered_menu_items.first.instance_of?(Page)
		assert ordered_menu_items.first.title == 'home'
  end

  test "last element in sorted menu items should be history page" do
		menu_items = get_menu_items

		ordered_menu_items = order_menu_items(menu_items)

		assert ordered_menu_items.last.instance_of?(Page)
		assert ordered_menu_items.last.title == 'history'
		#ordered_menu_items.each{|menu_item| puts menu_item.inspect}
  end
end
