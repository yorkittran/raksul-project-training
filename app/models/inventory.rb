class Inventory < ApplicationRecord
  belongs_to :phone

  validates_numericality_of :quantity, less_than_or_equal_to: 1000
  validates_numericality_of :price, less_than_or_equal_to: 1_000_000

  # include Discard::Model
  # scope :kept, -> { undiscarded.joins(:phone).merge(Phone.kept) }

  # def kept?
  #   undiscarded? && phone.kept?
  # end
end
