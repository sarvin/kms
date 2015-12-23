class ChaptersController < ApplicationController
	def new
	end

	def create
		@chapter = Chapter.new(chapter_params)
		#render plain: params[:chapter].inspect
		#@chapter = Chapter.new(params.require(:chapter).permit(:name, :state))

		@chapter.save
		redirect_to @chapter
	end

	def show
		@chapter = Chapter.find(params[:id])
	end

	def index
		@chapters = Chapter.all
	end

	private
		def chapter_params
			params.require(:chapter).permit(:name, :state)
		end
end
