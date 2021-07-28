# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :account

  validates_uniqueness_of :data
  serialize :data, Hash
end
