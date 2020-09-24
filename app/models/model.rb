class Model < ApplicationRecord
  belongs_to :manufacturer
  belongs_to :os_name
  has_many :phones, dependent: :destroy

  include Discard::Model
end
