class Api::V1::VirfilesController < ApplicationController
  
  skip_before_filter  :verify_authenticity_token

  #list, return all the file in the directory
  def index
    pathBuf = path_params[:user_name] + path_params[:path]
    @a = Virfile.list(pathBuf);
  end

  def create
    phys_file = Physfile.create(create_params[:frag_num])
    pathBuf = path_params[:user_name] + path_params[:path]
    Virfile.create(pathBuf, create_params[:name], phys_file.id)
    Physfile.modify(phys_file.id, frag_params[:frag_num])
    params(:addr_arr) do |p|
      Fragfile.create(phys_file.id, p)
    end
  end

  #show all the frage
  def show
    pathBuf = show_params[:user_name] + path_params[:path]
    file = Virfile.find_by_path(pathBuf)
    @if_file = 0
    @frag_num = 0
    if file.phys_id >= 0
      @a = Fragfile.find_all(file.phys_id)
      @if_file = 1
      phys_file = Physfile.find_id(file.phys_id)
      @frag_num = phys_file.frag_num
    end
  end

  def update
  end

  def destroy
    pathBuf = show_params[:user_name] + path_params[:path]
    file = Virfile_find_by_path(pathBuf)
    Virfile.delete(file.id)
  end

  private
  def path_params
    params.require(:abs_path).permit(:user_name, :path)
  end

  def create_params
    params.require(:file_inf).permit(:frag_num, :name)
  end
  
end
