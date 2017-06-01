class User < ActiveRecord::Base
  has_many :topics, dependent: :destroy
  has_many :comments, dependent: :destroy
  # フォロー、フォロワーの関係性定義
  has_many :active_relationships, foreign_key: "follower_id", class_name: 'Relationship', dependent: :destroy
  has_many :passive_relationships, foreign_key: "followed_id", class_name: 'Relationship',  dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable

  mount_uploader :avatar, AvatarUploader

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

  def self.create_unique_string
    SecureRandom.uuid
  end

  def update_with_password(params, *options)
    if provider.blank?
      super
    else
      params.delete :current_password
      update_without_password(params, *options)
    end
  end

  def follow!(other_user)
    active_relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    active_relationships.find_by(followed_id: other_user.id)
  end
end
