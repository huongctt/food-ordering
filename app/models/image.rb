class Image < ApplicationRecord
  belongs_to :food
  mount_uploader :image, ImageUploader
end
