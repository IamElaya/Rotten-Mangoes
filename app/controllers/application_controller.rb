class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 

  def create
        @user = User.new(user_params)

        if @user.save
          session[:user_id] = @user.id # auto log in
          redirect_to movies_path
        else
          render :new
        end
      end

       protect_from_forgery with: :exception

end
