module Navigable
  extend ActiveSupport::Concern

  included do
    has_one :public_navigation, :as => :navigable, dependent: :destroy
      accepts_nested_attributes_for :public_navigation, allow_destroy: true

    scope :publicly_navigable, -> { joins(:public_navigation).where('public_navigations.active': true) }
    scope :privately_navigable, -> { joins(:public_navigation).where('public_navigations.active': false) }
  end
end
