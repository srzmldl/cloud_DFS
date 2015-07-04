# -*- coding: utf-8 -*-
class Api::V1::SessionsController < ApplicationController
  def create
    @flag = login(name: create_params[:name], password: create_params[:password])
    if @flag
      @user = User.find_by(name: create_params[:name])
    else
      @user = nil
    end

    private
    
    def create_params
      params.require(:user).permit(:name, :password)
    end
  end
end
