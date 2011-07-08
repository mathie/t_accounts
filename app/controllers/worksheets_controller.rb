class WorksheetsController < ApplicationController
  respond_to :html

  def index
    @worksheets = Worksheet.all
    respond_with(@worksheets)
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
