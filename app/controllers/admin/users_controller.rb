class Admin::UsersController < Admin::BaseController
  def index
    @chapters = Chapter.all
  end

  def show
    @user = User.find(params[:id])
  end
end
