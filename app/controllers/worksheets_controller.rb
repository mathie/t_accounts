class WorksheetsController < ApplicationController
  respond_to :html

  def index
    @worksheets = Worksheet.all
    respond_with(@worksheets)
  end

  def show
    @worksheet = Worksheet.includes(:accounts).find(params[:id])
    respond_with(@worksheet)
  end

  def new
    @worksheet = Worksheet.new
    respond_with(@worksheet)
  end

  def edit
    @worksheet = Worksheet.find(params[:id])
    respond_with(@worksheet)
  end

  def create
    @worksheet = Worksheet.new(params[:worksheet])
    if @worksheet.save
      flash[:notice] = "Worksheet created."
    end
    respond_with(@worksheet)
  end

  def update
    @worksheet = Worksheet.find(params[:id])
    if @worksheet.update_attributes(params[:worksheet])
      flash[:notice] = "Worksheet details successfully updated."
    end
    respond_with(@worksheet)
  end

  def destroy
    @worksheet = Worksheet.find(params[:id])
    if @worksheet.destroy
      flash[:notice] = "Worksheet has been deleted."
    else
      flash[:alert] = "Failed to delete the worksheet."
    end
    respond_with(@worksheet)
  end
end
