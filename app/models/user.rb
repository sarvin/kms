class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :chapter
  has_one :address, :as => :addressable
    accepts_nested_attributes_for :address

	scope :orphaned, -> { where(chapter_id: nil) }

  def name
    "#{name_first} #{name_last}".titleize
  end
end
