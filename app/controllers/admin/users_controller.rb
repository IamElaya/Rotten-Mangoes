class Admin::UsersController < ApplicationController

before_action :require_admin

  # Methods omitted

  def require_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end

  def index
    @users = User.order(:lastname).page params[:page]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to movies_path, notice: "Welcome aboard, #{@user.firstname}!"
    else
      render :new
    end
  end

  def update
        @user = User.find(params[:id])

        if @user.update_attributes(user_params)
          redirect_to admin_user_path(@user)
        else
          render :edit
        end
  end

  def edit
    if params[:admin]
      @user = User.find(params[:id])
      @user.admin = params[:admin]
    else
      @user = User.find(params[:id])
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
        @user = User.find(params[:id])
        UserMailer.welcome_email(@user).deliver
        @user.destroy
          redirect_to admin_user_path
    end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation)
  end

  def paginate

  end

  helper_method :paginate
end
