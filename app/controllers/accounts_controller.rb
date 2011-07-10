class AccountsController < ApplicationController
  respond_to :html

  before_filter :load_worksheet

  def index
    respond_to do |format|
      format.js { render partial: 'accounts', content_type: :html, locals: { accounts: @worksheet.accounts } }
      format.html { redirect_to @worksheet }
    end
  end

  def new
    @account = @worksheet.accounts.build
  end

  def edit
    @account = @worksheet.accounts.find(params[:id])
  end

  def create
    @account = @worksheet.accounts.build(params[:account])
    if @account.save
      flash[:notice] = "Account #{@account.name} created."
    end
    respond_with(@worksheet, @account, location: @worksheet)
  end

  def update
    @account = @worksheet.accounts.find(params[:id])
    if @account.update_attributes(params[:account])
      flash[:notice] = "Account #{@account.name} updated."
    end
    respond_with(@worksheet, @account, location: @worksheet)
  end
end