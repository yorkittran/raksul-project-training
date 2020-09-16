class Memory < ApplicationRecord
  has_many :phones, dependent: :destroy
end
