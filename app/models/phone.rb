class Phone < ApplicationRecord
  belongs_to :body_color
  belongs_to :memory
  belongs_to :os_version
  belongs_to :model
  belongs_to :user
  has_many :inventories, dependent: :destroy

  # include Discard::Model
  # scope :kept, -> { undiscarded.joins(:model).merge(Model.kept) }

  # def kept?
  #   undiscarded? && model.kept?
  # end
end
