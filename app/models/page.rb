class Page < ActiveRecord::Base
	belongs_to :pageable, :polymorphic => true

	scope :orphaned, -> { where(pageable_type: nil, pageable_id: nil) }
end
