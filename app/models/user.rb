class User < ActiveRecord::Base
  has_many :topics, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable

  def self.find_for_facebook_oauth(auth, signed_in_resourse=nil)
    user = User.find_by(email: auth.info.email)

    unless user
      user = User.new(
        name:      auth.extra.raw_info.name,
        provider:  auth.provider,
        uid:       auth.uid,
        email:     auth.info.email ||= "#{auth.uid}-#{auth.provider}@example.com",
        image_url: auth.info.image,
        password:  Devise.friendly_token[0..20]
      )
      user.skip_confirmation!
      user.save(validate: false)
    end
    user
  end

  def self.find_for_twitter_oauth(auth, signed_in_resourse=nil)
    user = User.find_by(email: auth.info.email)

    unless user
      user = User.new(
        name:      auth.info.nickname,
        provider:  auth.provider,
        uid:       auth.uid,
        email:     auth.info.email ||= "#{auth.uid}-#{auth.provider}@example.com",
        image_url: auth.info.image,
        password:  Devise.friendly_token[0..20]
      )
      user.skip_confirmation!
      user.save(validate: false)
    end
    user
  end
end
