class Account < ActiveRecord::Base
  belongs_to :worksheet

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
end
