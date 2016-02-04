class State < ActiveRecord::Base
  has_many :chapters
  has_one :page, :as => :pageable

  scope :populated, -> { joins(:chapters).uniq }
  scope :populated_with_publicly_navigable, -> { joins(:chapters).merge(Chapter.publicly_navigable).uniq.order(:name) }

  def titleize_name
    name.titleize
  end
end
