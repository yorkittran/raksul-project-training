class OsName < ApplicationRecord
  has_one_attached :logo
  validates :name, presence: true
  validate :acceptable_image

  def acceptable_image
    return unless logo.attached?

    errors.add(:logo, "is too big") unless logo.byte_size <= 5.megabytes

    acceptable_types = ["image/jpeg", "image/png"]
    errors.add(:logo, "must be a JPEG or PNG") unless acceptable_types.include?(logo.content_type)
  end
end
