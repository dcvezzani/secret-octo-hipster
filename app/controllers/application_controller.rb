class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!, except: [:sign_in, :sign_out]

  def check_load_style
    @layout = (params[:load_style] == 'partial') ? 'weed_patch' : true
  end
  
  def load_client
    @client ||= (params[:client_id] and Client.find(params[:client_id]))
    @client ||= (params[:settlor_id] and Settlor.find(params[:settlor_id]))
  end
end
