class Model < ApplicationRecord
  belongs_to :manufacturer
  belongs_to :os_name
  delegate :name, to: :manufacturer, prefix: true
  delegate :name, to: :os_name, prefix: true
end
