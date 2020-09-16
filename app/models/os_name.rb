class OsName < ApplicationRecord
  has_many :os_versions, dependent: :destroy
end
