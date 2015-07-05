class Api::V1::VirfilesController < ApplicationController
  
  skip_before_filter  :verify_authenticity_token
  #create file/files
  def create
  end

  #list, return all the file 
  def index
  end

  def create
  end

  def show
    
  end

  def update
  end

  def destroy
    delete(params[:id]);
  end
  
end
