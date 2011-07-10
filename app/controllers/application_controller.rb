class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!

  protected
  def load_worksheet
    @worksheet = current_user.worksheets.find(params[:worksheet_id])
  end
end
