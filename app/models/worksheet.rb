class Worksheet < ActiveRecord::Base
  has_many :accounts
  has_many :transactions
  belongs_to :user

  validates :name,      :presence => true
  validates :narrative, :presence => true

  attr_accessible :name, :narrative

  def debits_total
    accounts.select { |account| account.debit_balance_carried_down? }.sum(&:balance_carried_down)
  end

  def credits_total
    accounts.select { |account| account.credit_balance_carried_down? }.sum(&:balance_carried_down)
  end
end
