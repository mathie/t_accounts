class Account < ActiveRecord::Base
  extend ActiveSupport::Memoizable

  belongs_to :worksheet
  has_many :credit_transactions, class_name: 'Transaction', foreign_key: 'credit_account_id', dependent: :nullify
  has_many :debit_transactions,  class_name: 'Transaction', foreign_key: 'debit_account_id',  dependent: :nullify

  default_scope order: :code

  validates :name, presence: true, uniqueness: { scope: :worksheet_id }
  validates :code, presence: true, uniqueness: { scope: :worksheet_id }, length: { is: 3 }, format: { with: /^\d{3}$/ }

  attr_accessible :name, :code

  after_initialize :default_code_to_next_available

  def code=(new_code)
    # Only zero-pad the code if it's valid in the first place. We still get
    # called with invalid codes.
    if new_code =~ /^\d+$/
      write_attribute(:code, "%03d" % new_code.to_i)
    else
      # Let the validations deal with invalid codes.
      write_attribute(:code, new_code)
    end
  end

  def zipped_transactions
    if debit_transactions.length >= credit_transactions.length
      debit_transactions.zip(credit_transactions)
    else
      credit_transactions.zip(debit_transactions).map { |a, b| [b, a] }
    end
  end
  memoize :zipped_transactions

  def debits_subtotal
    debit_transactions.sum :amount
  end
  memoize :debits_subtotal

  def credits_subtotal
    credit_transactions.sum :amount
  end
  memoize :credits_subtotal

  def balance_carried_down?
    debit_balance_carried_down? || credit_balance_carried_down?
  end
  memoize :balance_carried_down?

  def debit_balance_carried_down?
    debits_subtotal < credits_subtotal
  end
  memoize :debit_balance_carried_down?

  def credit_balance_carried_down?
    debits_subtotal > credits_subtotal
  end
  memoize :credit_balance_carried_down?

  def balance_carried_down
    (credits_subtotal - debits_subtotal).abs
  end
  memoize :balance_carried_down

  def debit_balance_brought_down?
    debits_subtotal > credits_subtotal
  end
  memoize :debit_balance_brought_down?

  def credit_balance_brought_down?
    debits_subtotal < credits_subtotal
  end
  memoize :credit_balance_brought_down?

  def balance_brought_down?
    debit_balance_brought_down? || credit_balance_brought_down?
  end
  memoize :balance_brought_down?

  def balance_brought_down
    balance_carried_down
  end
  memoize :balance_brought_down

  def total
    [credits_subtotal, debits_subtotal].max
  end
  memoize :total

  private
  def default_code_to_next_available
    self.code ||= self.class.next_available_code(worksheet_id)
  end

  def self.next_available_code(worksheet_id)
    highest_assigned_code(worksheet_id).succ
  end

  def self.highest_assigned_code(worksheet_id)
    connection.execute("SELECT MAX(code) AS code FROM #{table_name} WHERE worksheet_id = #{connection.quote worksheet_id}").first["code"] || '000'
  end
end
