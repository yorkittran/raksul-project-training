class Model < ApplicationRecord
  belongs_to :manufacturer
  belongs_to :os_name
  has_many :phones, dependent: :destroy

  validates :year_of_manufacture, numericality: { only_integer: true }

  include Discard::Model
end
