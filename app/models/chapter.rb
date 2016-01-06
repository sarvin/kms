class Chapter < ActiveRecord::Base
	validates :name, presence: true,
		uniqueness: true
	#validates :state_id, presence: true

	belongs_to :state

	has_one :page, :as => :pageable, dependent: :destroy
	#accepts_nested_attributes_for :page

	scope :orphaned, -> { where(state_id: nil) }
end
