class State < ActiveRecord::Base
  has_many :chapters
  has_one :page, :as => :pageable

  scope :populated, -> { joins(:chapters).uniq }

  def titleize_name
    name.titleize
  end
end
