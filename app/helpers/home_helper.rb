module HomeHelper
	def get_menu_items
		states = State.joins(:chapters)
		chapters = Chapter.where('state_id' => nil)
		pages = Page.where('pageable_type' => nil)

		menu_items = states + chapters + pages

		return menu_items
	end

	def order_menu_items menu_items
		menu_item_hash = {}
		menu_item_is_page = []

		menu_items.each do |menu_item|
			if menu_item.instance_of?(State)
				menu_item_hash[menu_item.name] = menu_item
			elsif menu_item.instance_of?(Chapter)
				menu_item_hash[menu_item.name] = menu_item
			elsif menu_item.instance_of?(Page)
				# set these aside (we insert them into our sorted array later)
				menu_item_is_page.push(menu_item)
			end
		end

		sorted_menu_items = []
		menu_item_hash.sort_by{|key, menu_item| key.downcase}.each do |key, menu_item|
			sorted_menu_items.push(menu_item)
		end

		menu_item_is_page.each do |menu_item|
			if menu_item.title && menu_item.title.downcase == 'home'
				sorted_menu_items.unshift(menu_item)
			elsif menu_item.title && menu_item.title.downcase == 'history'
				sorted_menu_items.push(menu_item)
			end
		end

		return sorted_menu_items
	end

	def generate_menu_item_info
	end
end
