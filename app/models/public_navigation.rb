class PublicNavigation < ActiveRecord::Base
  belongs_to :navigable, polymorphic: true
end
