class Chapter < ActiveRecord::Base
	validates :name, presence: true,
		uniqueness: true
	#validates :state_id, presence: true

	belongs_to :state

	has_one :page, :as => :pageable, dependent: :destroy
	#accepts_nested_attributes_for :page

	scope :adopted, -> { where.not(state_id: nil) }
	scope :orphaned, -> { where(state_id: nil) }
end
