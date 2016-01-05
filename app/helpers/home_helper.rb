module HomeHelper
	def get_main_navigation_items
		states = State.joins(:chapters)
		chapters = Chapter.where('state_id' => nil)
		pages = Page.where('pageable_type' => nil)

		navigation_items = states + chapters + pages

		return navigation_items
	end

	def sort_navigation_items_for_main_navigation navigation_items
		item_hash = {}
		item_is_page = []

		navigation_items.each do |item|
			if item.instance_of?(State)
				item_hash[item.name] = item
			elsif item.instance_of?(Chapter)
				item_hash[item.name] = item
			elsif item.instance_of?(Page)
				item_is_page.push(item) # set these aside (we insert them into our sorted array later)
			end
		end

		sorted_items = []
		item_hash.sort_by{|key, menu_item| key.downcase}.each do |key, item|
			sorted_items.push(item)
		end

		item_is_page.each do |item|
			if item.title? && item.title.downcase == 'home'
				sorted_items.unshift(item)
			elsif item.title? && item.title.downcase == 'history'
				sorted_items.push(item)
			end
		end

		return sorted_items
	end

	def convert_main_navigation_items_to_links sorted_menu_items
		menu_item_data = []

		sorted_menu_items.each do |menu_item|
			if menu_item.instance_of?(State)
				menu_item_data.push(self.create_main_navigation_state_link(menu_item))
			elsif menu_item.instance_of?(Chapter)
				menu_item_data.push(self.create_main_navigation_chapter_link(menu_item))
			elsif menu_item.instance_of?(Page)
				menu_item_data.push(self.create_main_navigation_page_link(menu_item))
			end
		end

		return menu_item_data
	end

	def get_main_navigation_link_list
		navigation_items = self.get_main_navigation_items
		ordered_items = self.sort_navigation_items_for_main_navigation(navigation_items)
		main_navigation_link_list = self.convert_main_navigation_items_to_links(ordered_items)

		return main_navigation_link_list
	end

	def create_main_navigation_state_link state
		link = link_to(
			state.name.upcase,
			state_path(state),
			class: "small radius button"
		)

		return link
	end

	def create_main_navigation_chapter_link chapter
		link = link_to(
			chapter.name.upcase,
			chapter_path(chapter),
			class: "small radius button"
		)

		return link
	end

	def create_main_navigation_page_link page
		link = link_to(
			page.title.upcase,
			page_path(page),
			class: "small radius button"
		)

		return link
	end
end
