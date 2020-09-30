class Memory < ApplicationRecord
  validates :amount, presence: true
  validates :display_name, presence: true
  validates :amount, numericality: { only_integer: true }
end
