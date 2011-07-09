class Worksheet < ActiveRecord::Base
  has_many :accounts

  validates :name,      :presence => true
  validates :narrative, :presence => true
end
