class Worksheet < ActiveRecord::Base
  validates :name,      :presence => true
  validates :narrative, :presence => true
end
