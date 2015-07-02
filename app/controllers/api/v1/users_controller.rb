class Api::V1::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  #def create
   # @user = User.find_by(name: create_params[:name])
   # if (@user)
   # end
    
end
