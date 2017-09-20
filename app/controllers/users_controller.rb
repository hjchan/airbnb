class UsersController < Clearance::UsersController
  
  before_action :check_user, only: [:edit, :update]

  def edit
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    if @user
      return @user
    else
      flash[:notice] = "User not found"
      redirect_to root_path
    end
  end

  def update
    # u_params = params[:user]
    # u_params[:birthday] = Date.new(u_params["birthday(1i)"].to_i, u_params["birthday(2i)"].to_i, u_params["birthday(3i)"].to_i)
    current_user.update_attributes!(update_from_params)
    redirect_to user_path(current_user)
  end

  def new
    @user = User.new
    render template: "users/new"
  end

	def create
    @user = User.new(user_from_params)
    # @user.picture.default_url
    if @user.save
      sign_in @user
      redirect_to edit_user_path(@user)
    else
      render template: "users/new"
    end
  end

  private

  def user_from_params
    params.require(:user).permit(:email, :password, :name)
  end

  def update_from_params
    params.require(:user).permit(:name, :phone, :country, :gender, :birthday, :picture)
  end

  def check_user
    unless current_user.id == params[:id].to_i
      flash[:notice] = "You are not authorise!"
      redirect_to root_path
    end
  end

end