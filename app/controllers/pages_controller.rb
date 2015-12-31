class PagesController < ApplicationController
	def new
		@page = Page.new
	end

	def index
		@pages = Page.all
	end

	def create
		@pageable = find_pageable
		if @pageable
			@page = @pageable.build_page(page_params)
		else
			@page = Page.new(page_params)
		end

		@page.save

		if @pageable
			redirect_to polymorphic_path(@pageable)
		end

		redirect_to action: "index"
	end

	def edit
		@page = Page.find(params[:id])
		@pageable = @page.pageable
	end

	def update
		@page = Page.find(params[:id])
		@pageable = @page.pageable

		#logger.debug "page params body is: #{params[:page][:body]}"
		if @page.update(page_params)
			redirect_to polymorphic_path(@pageable)
		else
			render 'edit'
		end
	end

	def destroy
		@page = Page.find(params[:id])
		@pageable = @page.pageable
		@page.destroy

		if @pageable
			redirect_to polymorphic_path(@pageable)
		end

		redirect_to action: "index"
	end

	private
    def page_params
      params.require(:page).permit(:title, :sub_title, :body)
    end

	private
		def find_pageable
			params.each do |name, value|
				if name =~ /(.+)_id$/
					return $1.classify.constantize.find(value)
				end
			end
			nil
		end
end
