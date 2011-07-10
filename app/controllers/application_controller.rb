class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!

  protected
  def load_worksheet
    @worksheet = Worksheet.find(params[:worksheet_id])
  end
end
