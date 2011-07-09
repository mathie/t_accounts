class Worksheet < ActiveRecord::Base
  has_many :accounts
  has_many :transactions

  validates :name,      :presence => true
  validates :narrative, :presence => true

  attr_accessible :name, :narrative
end
