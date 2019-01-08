class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook]

  has_many :autorizations

  has_many :answers, dependent: :destroy
  has_many :questions, dependent: :destroy

  def self.find_for_oauth(auth)
    autorization = Autorization.where(provider:auth.provider, uid:auth.uid.to_s).first
    return autorization.user if autorization

    email = auth.info[:email]
    user = User.where(email: email).first
    if user
      user.create_autorization(auth)
    else
      password = Devise.friendly_token[0, 20]
      user = User.create!(email: email, password: password, password_confirmation: password)
      user.create_autorization(auth)
    end
    user
  end

  def self.send_daily_digest
    find_each.each do |user|
      DailyMailer.digest(user).deliver_later
    end
  end

  def create_autorization(auth)
    self.autorizations.create(provider: auth.provider, uid: auth.uid)
  end
end