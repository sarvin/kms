class StatesController < ApplicationController
  def view
		#render plain: params.inspect
		@state = State.find_by(name: params[:state_name])
  end

  def show
		@state = State.find(params[:id])
  end
end
