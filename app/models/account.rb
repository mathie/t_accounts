class Account < ActiveRecord::Base
  belongs_to :worksheet
  has_many :credit_transactions, class_name: 'Transaction', foreign_key: 'credit_account_id'
  has_many :debit_transactions,  class_name: 'Transaction', foreign_key: 'debit_account_id'

  default_scope :order => :code

  validates :name, presence: true, uniqueness: { scope: :worksheet_id }
  validates :code, presence: true, uniqueness: { scope: :worksheet_id }, length: { is: 3 }, format: { with: /^\d{3}$/ }

  attr_accessible :name, :code

  def code=(new_code)
    # Only zero-pad the code if it's valid in the first place. We still get
    # called with invalid codes.
    if new_code =~ /^\d+$/
      write_attribute(:code, "%03d" % new_code)
    else
      # Let the validations deal with invalid codes.
      write_attribute(:code, new_code)
    end
  end

  def zipped_transactions
    debit_transactions.zip(credit_transactions)
  end

  def debits_subtotal
    debit_transactions.sum :amount
  end

  def credits_subtotal
    credit_transactions.sum :amount
  end

  def balance_carried_down?
    debit_balance_carried_down? || credit_balance_carried_down?
  end

  def debit_balance_carried_down?
    debits_subtotal < credits_subtotal
  end

  def credit_balance_carried_down?
    debits_subtotal > credits_subtotal
  end

  def balance_carried_down
    (credits_subtotal - debits_subtotal).abs
  end

  def debit_balance_brought_down?
    debits_subtotal > credits_subtotal
  end

  def credit_balance_brought_down?
    debits_subtotal < credits_subtotal
  end

  def balance_brought_down
    balance_carried_down
  end

  def total
    [credits_subtotal, debits_subtotal].max
  end
end
