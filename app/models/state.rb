class State < ActiveRecord::Base
	has_many :chapters
	has_one :page, :as => :pageable

	def titleize_name
		name.titleize
	end
end
