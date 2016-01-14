class Page < ActiveRecord::Base
  include Bootsy::Container

	belongs_to :pageable, :polymorphic => true

	scope :orphaned, -> { where(pageable_type: nil, pageable_id: nil) }
end
