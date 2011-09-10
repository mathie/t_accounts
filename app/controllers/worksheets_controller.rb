class WorksheetsController < ApplicationController
  respond_to :html

  def index
    @worksheets = current_user.worksheets.order(:name).page(params[:page])
    respond_with(@worksheets)
  end

  def show
    @worksheet = current_user.worksheets.find(params[:id])
    respond_with(@worksheet)
  end

  def trial_balance
    @worksheet = current_user.worksheets.find(params[:id])
    respond_with(@worksheet)
  end

  def new
    @worksheet = current_user.worksheets.build
    respond_with(@worksheet)
  end

  def edit
    @worksheet = current_user.worksheets.find(params[:id])
    respond_with(@worksheet)
  end

  def create
    @worksheet = current_user.worksheets.build(params[:worksheet])
    if @worksheet.save
      flash[:notice] = "Worksheet created."
    end
    respond_with(@worksheet)
  end

  def update
    @worksheet = current_user.worksheets.find(params[:id])
    if @worksheet.update_attributes(params[:worksheet])
      flash[:notice] = "Worksheet details successfully updated."
    end
    respond_with(@worksheet)
  end

  def destroy
    @worksheet = current_user.worksheets.find(params[:id])
    if @worksheet.destroy
      flash[:notice] = "Worksheet has been deleted."
    else
      flash[:alert] = "Failed to delete the worksheet."
    end
    respond_with(@worksheet)
  end
end
