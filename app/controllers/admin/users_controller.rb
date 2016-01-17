class Admin::UsersController < Admin::BaseController
  ### A frequent practice is to place the standard CRUD actions in each
  ### controller in the following order: index, show, new, edit, create, update
  ### and destroy
  def index
    @chapters = Chapter.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

	def update
    @user = User.find(params[:id])

		if @user.update(user_params)
      redirect_to [:admin, @user]
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name_first, :name_last, :chapter_id, :email)
    end
end
