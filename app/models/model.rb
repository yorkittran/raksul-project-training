class Model < ApplicationRecord
  belongs_to :manufacturer
  belongs_to :os_name
  has_many :phones

  delegate :name, to: :manufacturer, prefix: true
  delegate :logo, to: :manufacturer, prefix: true
  delegate :name, to: :os_name, prefix: true
  delegate :logo, to: :os_name, prefix: true
end
