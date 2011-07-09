class WorksheetsController < ApplicationController
  respond_to :html

  def index
    @worksheets = Worksheet.all
    respond_with(@worksheets)
  end

  def show
    @worksheet = Worksheet.find(params[:id])
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
end
