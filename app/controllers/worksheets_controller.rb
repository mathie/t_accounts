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

  def create
    @worksheet = Worksheet.new(params[:worksheet])
    @worksheet.save
    respond_with(@worksheet)
  end
end
