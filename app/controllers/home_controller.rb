class HomeController < ApplicationController
  def index
		@page = Page.find_by(title: params[:title])

		unless @page
			@page = Page.find_by(title: 'home')
		end
  end
end
