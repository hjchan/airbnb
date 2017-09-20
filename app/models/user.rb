class User < ApplicationRecord
  include Clearance::User
  has_many :listings
  has_many :authentications, dependent: :destroy
  has_many :reservations, through: :listings
  mount_uploader :picture, UserProfileUploader

  enum role: [:user, :admin]

	def self.create_with_auth_and_hash(authentication, auth_hash)
	  user = self.create!(
	    name: auth_hash[:info][:name],
	    email: auth_hash[:extra][:raw_info][:email],
	    password: SecureRandom.hex(6),
      birthday: DateTime.strptime(auth_hash[:extra][:raw_info][:birthday], '%m/%d/%Y'),
      gender: auth_hash[:extra][:raw_info][:gender].capitalize,
      remote_picture_url: auth_hash[:info][:image]
	  )
	  user.authentications << authentication
	  return user
	end

	# grab fb_token to access Facebook for user data
	def fb_token
	  x = self.authentications.find_by(provider: 'facebook')
	  return x.token unless x.nil?
	end

end
