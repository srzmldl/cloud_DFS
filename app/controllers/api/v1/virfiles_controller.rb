class Api::V1::VirfilesController < ApplicationController
  
  skip_before_filter  :verify_authenticity_token
  before_action :require_verify
  
  #list, return all the file in the directory
  def index
    @index_list = Virfile.list(path_params[:user_name], path_params[:path]);
  end

  def create
    phys_id = -1
    if (create_params[:if_file])
      phys_file = Physfile.creat(create_params[:frag_num])
      phys_id = phys_file.id;
      Physfile.modify(phys_file.id, create_params[:frag_num])
      frag_arr_params.each do |p|
        #  debugger
        Fragfile.creat(phys_file.id, p[:addr], p[:index])
      end
    end
    #debugger
    Virfile.creat(path_params[:user_name], path_params[:path], create_params[:name], phys_id)
  end
  
  #show all the frage
  def show
  #  debugger
    file = Virfile.find_by_path(path_params[:user_name], path_params[:path])
   # debugger
    @if_file = 0
    @frag_num = 0
    #debugger
    if file.phys_id >= 0
      @frag_list = Fragfile.find_all(file.phys_id)
      @if_file = 1
     # debugger
      phys_file = Physfile.find_id(file.phys_id)
      @frag_num = phys_file.frag_num
    end
  end

  def update
  end

  def destroy
    Virfile.delete(path_params[:user_name], path_params[:path])
  end
  
  private

  def require_verify
    user_to_verify = User.find_by(name: verify_info[:user_name])
    if user_to_verify.auth_token(verify_info[:authen_token])
      return api_error(status: 403)
    end
  end
  
  def path_params
    params.require(:abs_path).permit(:user_name, :path)
  end

  def create_params
    params.require(:file_inf).permit(:frag_num, :name, :if_file)
  end

  def frag_arr_params
    params.require(:frag_arr)#.permit(:addr, :index)
  end

  def token_params
    params.require(:verify_info).permit(:user_name, :authen_token)
  end
end
