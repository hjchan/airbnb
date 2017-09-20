class Listing < ApplicationRecord
	belongs_to :user
  has_many :reservations
  mount_uploaders :pictures, PropertyPictureUploader
end
