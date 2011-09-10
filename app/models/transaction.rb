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
    self.class.connection.execute "SET CONSTRAINTS ALL DEFERRED"
    decrement_previous_subsequent_transaction_positions if dated_on_was.present?
    self.position = max_position_for_dated_on + 1
    increment_subsequent_transaction_positions
  end

  def decrement_previous_subsequent_transaction_positions
    self.class.update_all 'position = position - 1', ['worksheet_id = ? AND position > ?', worksheet_id, position]
  end

  def max_position_for_dated_on
    max_position = self.class.unscoped.
      select('MAX(position) as max_position').
      where('worksheet_id = ? AND dated_on <= ?', worksheet_id, dated_on).
      first.try(:max_position)

    (max_position || '0').to_i
  end

  # FIXME: This is crazy inefficient. What I want to do is:
  #
  #   UPDATE transactions SET position = position + 1 WHERE worksheet_id = ? AND position >= ?
  #
  # but sadly I can't because it violates the uniqueness constraint on
  # (worksheet_id, position). Normally, the workaround would be to set the
  # constraint to be deferred 'til the end of the transaction, but we can't do
  # that with the Rails schema dumper and it seems too much like hard work to
  # work around that for now.
  def increment_subsequent_transaction_positions
    self.class.unscoped.where('worksheet_id = ? AND position >= ?', worksheet_id, position).order('position DESC').each do |transaction|
      transaction.update_attribute :position, transaction.position + 1
    end
  end
end
