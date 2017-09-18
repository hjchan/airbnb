Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_KEY'], ENV['FACEBOOK_APP_SECRET'],
  scope: 'email, public_profile, user_birthday',
  info_fields: 'name, gender, picture, email, birthday',
  secure_image_url: true,
  image_size: 'large',
  display: 'page'
end