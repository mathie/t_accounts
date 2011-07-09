class AccountsController < ApplicationController
  respond_to :html

  before_filter :load_worksheet

  def new
    @account = @worksheet.accounts.build
  end

  def create
    @account = @worksheet.accounts.build(params[:account])
    if @account.save
      flash[:notice] = "Account #{@account.name} created."
    end
    respond_with(@worksheet, @account, location: @worksheet)
  end

  private
  def load_worksheet
    @worksheet = Worksheet.find(params[:worksheet_id])
  end
end