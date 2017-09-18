class Listing < ApplicationRecord
	belongs_to :user
  mount_uploaders :pictures, PropertyPictureUploader
end
