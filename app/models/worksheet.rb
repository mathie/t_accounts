class Worksheet < ActiveRecord::Base
  has_many :accounts,     dependent: :destroy
  has_many :transactions, dependent: :destroy
  belongs_to :user

  validates :name,      presence: true
  validates :narrative, presence: true

  attr_accessible :name, :narrative

  scope :recent, limit(10).order("updated_at DESC")

  paginates_per 5

  def debits_total
    accounts.select { |account| account.debit_balance_carried_down? }.sum(&:balance_carried_down)
  end

  def credits_total
    accounts.select { |account| account.credit_balance_carried_down? }.sum(&:balance_carried_down)
  end
end
