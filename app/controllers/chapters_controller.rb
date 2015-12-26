class ChaptersController < ApplicationController
	def new
		@chapter = Chapter.new
	end

	def create
		@chapter = Chapter.new(chapter_params)

		if @chapter.save
			redirect_to @chapter
		else
			render 'new'
		end

		#render plain: params[:chapter].inspect
		#@chapter = Chapter.new(params.require(:chapter).permit(:name, :state))
	end

	def index
		@chapters = Chapter.all
	end

	def edit
		@chapter = Chapter.find(params[:id])
	end

	def show
		@chapter = Chapter.find(params[:id])
	end

	def update
		@chapter = Chapter.find(params[:id])

		if @chapter.update(chapter_params)
			redirect_to @chapter
		else
			render 'edit'
		end
	end

def destroy
	@chapter = Chapter.find(params[:id])
	@chapter.destroy

	redirect_to chapters_path
end

	private
		def chapter_params
			params.require(:chapter).permit(:name, :state_id)
		end
end
