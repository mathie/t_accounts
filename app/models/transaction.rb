class Transaction < ActiveRecord::Base
  belongs_to :worksheet
  belongs_to :debit_account,  class_name: 'Account'
  belongs_to :credit_account, class_name: 'Account'

  default_scope order: 'dated_on, position'

  paginates_per 15

  validates :dated_on,          presence: true
  validates :description,       presence: true
  validates :debit_account_id,  presence: true
  validates :credit_account_id, presence: true
  validates :amount,            presence: true, numericality: { greater_than: 0 }

  attr_accessible :dated_on, :description, :debit_account_id, :credit_account_id, :amount

  # New/changed transactions always go in at the end of a day. We make this
  # happen by ordering by dated_on and position. Position is automatically
  # managed, and any time a transaction is entered, or the date is changed,
  # that transaction gets the current highest position + 1.
  #
  # FIXME: A psql sequence would probably do the job here...?
  before_save :update_position, if: :dated_on_changed?

  protected
  def update_position
    self.position = max_position + 1
  end

  def max_position
    self.class.max_position(worksheet_id)
  end

  def self.max_position(worksheet_id)
    max_position = connection.execute("SELECT MAX(position) AS position FROM #{table_name} WHERE worksheet_id = #{connection.quote worksheet_id}").first["position"]
    (max_position || '0').to_i
  end
end
