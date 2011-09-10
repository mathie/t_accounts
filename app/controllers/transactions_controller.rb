class TransactionsController < ApplicationController
  respond_to :html

  before_filter :load_worksheet

  def index
    @transactions = @worksheet.transactions.page(params[:page])
    respond_with(@transactions)
  end

  def new
    @transaction = @worksheet.transactions.build
    respond_with(@transaction)
  end

  def edit
    @transaction = @worksheet.transactions.find(params[:id])
    respond_with(@transaction)
  end

  def create
    @transaction = @worksheet.transactions.build(params[:transaction])
    if @transaction.save
      flash[:notice] = "Transaction successfully created."
    end
    respond_with(@transaction, location: @worksheet)
  end

  def update
    @transaction = @worksheet.transactions.find(params[:id])
    if @transaction.update_attributes(params[:transaction])
      flash[:notice] = "Transaction successfully updated."
    end
    respond_with(@transaction, location: @worksheet)
  end

  def destroy
    @transaction = @worksheet.transactions.find(params[:id])
    if @transaction.destroy
      flash[:notice] = "Transaction successfully deleted."
    end
    respond_with(@transaction, location: @worksheet)
  end
end