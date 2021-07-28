class Account < ApplicationRecord
  has_many :transactions

  validates_uniqueness_of :data
  serialize :data, Hash
end
