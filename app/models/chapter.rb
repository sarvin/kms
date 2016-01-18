class Chapter < ActiveRecord::Base
  belongs_to :state

  has_one :page, :as => :pageable, dependent: :destroy
  has_many :users, dependent: :nullify
  #accepts_nested_attributes_for :page

  validates :name, presence: true,
    uniqueness: true
  #validates :state_id, presence: true

  scope :adopted, -> { where.not(state_id: nil) }
  scope :orphaned, -> { where(state_id: nil) }

  def titleize_name
    name.titleize
  end
end
