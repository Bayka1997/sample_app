class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> {order(created_at: :desc)}
  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.maxContentMicroPost}
  validate  :picture_size

  def picture_size
    return unless picture.size > Settings.pictute_size.megabytes
    errors.add :picture, t("model.micropost.picture_size")
  end
end
