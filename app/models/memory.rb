class Memory < ApplicationRecord
  validates :amount, presence: true
  validates :display_name, presence: true
end
