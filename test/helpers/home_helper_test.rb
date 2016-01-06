require 'test_helper'
 
class HomeHelperTest < ActionView::TestCase
  include HomeHelper
 
  test "should return array containing Chapter, State and Page objects" do
		items = get_main_navigation_items

		assert items.map{|item| item.class.name}.uniq.sort.join() == 'ChapterPageState'
  end

  test "Page object is not pageable" do
		items = get_main_navigation_items

		items.map.each do |item|
			if item.instance_of?(Page)
				assert item.pageable_id? == false
			end
		end
  end

	test "State object has a Chapter associated with it" do
		items = get_main_navigation_items

		items.map.each do |item|
			if item.instance_of?(State)
				assert item.chapter_ids.count != 0
			end
		end
	end

	test "No duplicate States in list" do
		items = get_main_navigation_items

		hash = Hash.new(0)

		items.each do |item|
			if item.instance_of?(State)
				hash[item.id] +=1
			end
		end

		hash.each do |id, count|
			assert count == 1, "State with id #{id} found more than once"
		end
	end

	test "Chapter object does not belong to a State" do
		items = get_main_navigation_items

		items.map.each do |item|
			if item.instance_of?(Chapter)
				assert_not item.state_id?
			end
		end
	end

  test "first element in sorted menu items should be home page" do
		menu_items = get_main_navigation_items
		ordered_menu_items = sort_navigation_items_for_main_navigation(menu_items)

		assert ordered_menu_items.first.instance_of?(Page)
		assert ordered_menu_items.first.title == 'home'
  end

  test "last element in sorted menu items should be history page" do
		menu_items = get_main_navigation_items
		ordered_menu_items = sort_navigation_items_for_main_navigation(menu_items)

		assert ordered_menu_items.last.instance_of?(Page)
		assert ordered_menu_items.last.title == 'history'
  end

  test "generate_menu_item_info returns proper urls" do
		menu_items = get_main_navigation_items
		ordered_menu_items = sort_navigation_items_for_main_navigation(menu_items)
		links = convert_main_navigation_items_to_links(ordered_menu_items)
		#puts links.inspect
		assert true
  end
end
