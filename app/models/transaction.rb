class Transaction < ActiveRecord::Base
  belongs_to :worksheet
  belongs_to :debit_account,  class_name: 'Account'
  belongs_to :credit_account, class_name: 'Account'

  default_scope order: :position

  validates :dated_on,          presence: true
  validates :description,       presence: true
  validates :debit_account_id,  presence: true
  validates :credit_account_id, presence: true
  validates :amount,            presence: true, numericality: { greater_than: 0 }

  attr_accessible :dated_on, :description, :debit_account_id, :credit_account_id, :amount

  before_save :update_position, if: :dated_on_changed?
  after_destroy :decrement_previous_subsequent_transaction_positions

  protected
  def update_position
    decrement_previous_subsequent_transaction_positions if dated_on_was.present?
    self.position = max_position_for_dated_on
    increment_subsequent_transaction_positions
  end

  def decrement_previous_subsequent_transaction_positions
    self.class.update_all 'position = position - 1', ['worksheet_id = ? AND position > ?', worksheet_id, position]
  end

  def max_position_for_dated_on
    max_position = self.class.unscoped.find(:first,
      select:     'MAX(position) as max_position',
      conditions: ['worksheet_id = ? AND dated_on <= ?', worksheet_id, dated_on]
    ).max_position

    (max_position || '0').to_i + 1
  end

  def increment_subsequent_transaction_positions
    self.class.update_all 'position = position + 1', ['worksheet_id = ? AND dated_on > ?', worksheet_id, dated_on]
  end
end
