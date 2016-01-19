class Address < ActiveRecord::Base
  belongs_to :state
  belongs_to :addressable, polymorphic: true
end
