class ChaptersController < ApplicationController
	def new
	end

	def create
		render plain: params[:chapter].inspect
	end
end
