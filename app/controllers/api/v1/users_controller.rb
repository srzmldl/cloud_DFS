class Api::V1::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.find_by(name: create_params[:name])
    @state = 0;
    # -1 for exist
    if @user
      @state = -1
    else
      @state = 0
      @user = register(name: create_params[:name], psw: create_params[:password]);
    end

    def create_params
      params.require(:user).permit(:name, :password)
    end
end
