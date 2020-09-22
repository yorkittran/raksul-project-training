class Phone < ApplicationRecord
  belongs_to :body_color
  belongs_to :memory
  belongs_to :os_version
  belongs_to :model
  belongs_to :user
  has_many :inventories

  delegate :quantity, to: :inventory, prefix: true
end
