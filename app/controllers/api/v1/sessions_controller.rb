# -*- coding: utf-8 -*-
class Api::V1::SessionsController < ApplicationController

  skip_before_filter  :verify_authenticity_token
  
  def create
    @flag = User.login(create_params[:name], create_params[:password])
    if @flag
      @user = User.find_by(name: create_params[:name])
    else
      return api_error(status: 401)
    end
  end
  
  private
  
  def create_params
    params.require(:user).permit(:name, :password)
  end
  
end
