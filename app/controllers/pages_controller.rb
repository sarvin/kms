class PagesController < ApplicationController
	def create
		@pageable = find_pageable
		@page = @pageable.build_page(page_params)

		@page.save
		redirect_to polymorphic_path(@pageable)
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
