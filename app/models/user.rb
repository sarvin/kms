class User < ActiveRecord::Base
	scope :orphaned, -> { where(chapter_id: nil) }

  belongs_to :chapter
  has_one :address, :as => :addressable
    accepts_nested_attributes_for :address

  def name
    "#{name_first} #{name_last}".titleize
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
end
