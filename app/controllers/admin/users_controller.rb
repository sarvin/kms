class Admin::UsersController < Admin::BaseController
  def index
    @chapters = Chapter.all
  end
end
