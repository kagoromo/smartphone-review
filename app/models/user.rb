class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :reviews, dependent: :destroy
  #has_many :ratings, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :phones

  class << self
    def from_omniauth auth
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
      end
    end

    def new_with_session params, session
      if session["devise.user_attributes"]
        new session["devise.user_attributes"] do |user|
          user.attributes = params
          user.valid?
        end
      else
        super
      end
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password params, *options
    encrypted_password.blank? ? update_attributes(params, *options) : super
  end

  def link_with_facebook provider, uid = nil
    update_attributes provider: provider, uid: uid
  end

  def unlink_from_facebook
    update_attributes provider: nil, uid: nil
  end
end
