class Chapter < ActiveRecord::Base
	belongs_to :state
	validates :name, presence: true,
		uniqueness: true
	validates :state, presence: true
end
