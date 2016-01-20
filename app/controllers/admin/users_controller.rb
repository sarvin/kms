class Admin::UsersController < Admin::BaseController
  ### A frequent practice is to place the standard CRUD actions in each
  ### controller in the following order: index, show, new, edit, create, update
  ### and destroy
  def index
    @chapters = Chapter.all
  end

  def show
    @user = User.includes(:chapter).includes(:address).find(params[:id])
  end

  def new
    @user = User.new
    @user.password = Devise.friendly_token.first(8)
    @user.build_address
  end

  def edit
    @user = User.find(params[:id])

    if @user.address.nil?
      @user.build_address
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to [:admin, @user]
    else
      render 'new'
    end
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
    ### Remove the password key of the params hash if it’s blank.
    ### If not, Devise will fail to validate.
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    params.require(:user).permit(
      :name_first, :name_last, :chapter_id, :email, :password,
      address_attributes: [:id, :line_1, :line_2, :city, :state_id, :postal_code]
    )
  end
end
