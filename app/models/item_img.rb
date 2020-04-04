class ItemImg < ApplicationRecord
  mount_uploader :src, ImageUploader
  belongs_to :item, optional: true
end
