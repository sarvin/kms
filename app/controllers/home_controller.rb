class HomeController < ApplicationController
  def index
		if params[:title]
			@page = Page.find_by(title: params[:title])
		else
			@page = Page.find_by(title: 'home')
		end
  end
end
