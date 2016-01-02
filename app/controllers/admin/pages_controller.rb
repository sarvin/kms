class Admin::PagesController < ApplicationController
	def new
		@page = Page.new
		#render plain: params.inspect
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
			redirect_to polymorphic_path([:admin, @pageable])
		else
			redirect_to action: "index"
		end
	end

	def edit
		@page = Page.find(params[:id])
		@pageable = @page.pageable
	end

	def update
		@page = Page.find(params[:id])
		@pageable = @page.pageable

		if @page.update(page_params) && @pageable
			redirect_to polymorphic_path([:admin, @pageable])
		else
			render 'edit'
		end
	end

	def destroy
		@page = Page.find(params[:id])
		@pageable = @page.pageable
		@page.destroy

		if @pageable
			redirect_to polymorphic_path([:admin, @pageable])
		else
			redirect_to action: "index"
		end
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
