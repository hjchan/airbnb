class UsersController < Clearance::UsersController
  
  before_action :check_user, only: [:edit, :update]

  def edit
    @user = current_user
  end

  def update

  end

	def create
    @user = user_from_params

    if @user.save
      sign_in @user
      redirect_to edit_user_path(@user)
    else
      render template: "users/new"
    end
  end

  private

  def user_from_params
    email = user_params.delete(:email)
    password = user_params.delete(:password)
    first_name = user_params.delete(:first_name)
    last_name = user_params.delete(:last_name)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
      user.first_name = first_name
      user.last_name = last_name
    end
  end

  def check_user
    unless current_user.id == params[:id]
      redirect_to root_path
    end
  end

end