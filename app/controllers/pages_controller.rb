class PagesController < ApplicationController
	def create
    @chapter = Chapter.find(params[:chapter_id])
		@page = @chapter.create_page(page_params)
    redirect_to chapter_path(@chapter)
  end

	private
    def page_params
      params.require(:page).permit(:title, :sub_title, :body)
    end
end
