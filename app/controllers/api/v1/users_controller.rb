class Api::V1::UsersController < ApplicationController

  skip_before_filter  :verify_authenticity_token
  #return id, name, register_date, root_id
  def show
    @user = User.find(params[:id])
  end

  #return @state and @user(format like show)
  def create
    @user = User.find_by(name: create_params[:name])
    @state = 0;
    # -1 |name| < 3
    # -2 |psw| < 6
    # -3 user already exist
    # 0 normal
    @state = 0
    tmp = register(name: create_params[:name], psw: create_params[:password])
    if (tmp == -1) || (tmp == -2) || (tmp == -3)
      @state = tmp
      @user = nil
    else @user = tmp
    end
  end

  private

  def create_params
    params.require(:user).permit(:name, :password)
  end
  
end
