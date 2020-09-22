class Inventory < ApplicationRecord
  belongs_to :phone

  include Discard::Model
  scope :kept, -> { undiscarded.joins(:phone).merge(Phone.kept) }

  def kept?
    undiscarded? && phone.kept?
  end
end
