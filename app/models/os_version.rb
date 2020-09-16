class OsVersion < ApplicationRecord
  belongs_to :os_name
  has_many :phones, dependent: :destroy
end
