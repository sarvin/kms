class Chapter < ActiveRecord::Base
	validates :name, presence: true,
		uniqueness: true
	validates :state, presence: true
end
