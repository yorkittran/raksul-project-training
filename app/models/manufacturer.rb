class Manufacturer < ApplicationRecord
  has_many :models, dependent: :destroy
end
