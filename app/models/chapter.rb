class Chapter < ActiveRecord::Base
	validates :name, presence: true,
		format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" },
		uniqueness: true
	validates :state, presence: true,
		format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
end
