class Chapter < ActiveRecord::Base
	validates :name, presence: true,
		format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
	validates :state, presence: true,
		format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
end
