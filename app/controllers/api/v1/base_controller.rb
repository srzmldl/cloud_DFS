class Api::V1::BaseController < ApplicationController
# disable the CSRF token
  skip_before_filter :verify_authenticity_token
  
  def api_error(opts = {})
    render nothing: true, status: opts[:status]
  end
  
end
