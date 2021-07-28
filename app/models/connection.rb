class Connection < ApplicationRecord
  has_many :accounts
  
  validates_uniqueness_of :data
  serialize :data, Hash
end
