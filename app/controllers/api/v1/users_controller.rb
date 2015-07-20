class Api::V1::UsersController < ApplicationController

  skip_before_filter  :verify_authenticity_token
  #return id, name, register_date, root_id
  def show
    #debugger
    @user = User.find_by(name: show_params[:name])
    if @user == nil
      return api_error(status: 400)
    elsif !@user.auth_token(show_params[:authen_token])
      return api_error(status: 403)
    end
  end

  #return @state and @user(format like show)
  def create
    # -1 |name| < 3
    # -2 |psw| < 6
    # -3 user already exist
    # 0 normal
    @state = 0
    tmp = User.register(create_params[:name], create_params[:password])
    if (tmp == -1) || (tmp == -2) || (tmp == -3)
      @state = tmp
      @user = nil;
    else @user = tmp
    end
  end
  
  private

  def create_params
    params.require(:register_user).permit(:name, :password)
  end

  def show_params
    params.require(:show_user).permit(:name, :authen_token)
  end
  
end
