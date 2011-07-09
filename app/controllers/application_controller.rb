class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  def load_worksheet
    @worksheet = Worksheet.find(params[:worksheet_id])
  end
end
