class BodyColor < ApplicationRecord
  has_many :phones, dependent: :destroy
end
