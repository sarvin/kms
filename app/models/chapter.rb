class Chapter < ActiveRecord::Base
	belongs_to :state
	validates :name, presence: true,
		uniqueness: true
	validates :state_id, presence: true
end
