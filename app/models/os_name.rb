class OsName < ApplicationRecord
  has_one_attached :logo
  validates :name, presence: true
  validate :acceptable_image

  def acceptable_image
    return unless logo.attached?

    unless logo.byte_size <= 5.megabytes
      errors.add(:logo, "is too big")
    end

    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(logo.content_type)
      errors.add(:logo, "must be a JPEG or PNG")
    end
  end
end
