class User < ApplicationRecord
  before_save {email.downcase!}
  validates :name, presence: true, length: {maximum: Settings.maxName}
  validates :email, format: {with: Settings.VALID_EMAIL_REGEX},
  presence: true, length: {maximum: Settings.maxEmail},
  uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: Settings.minPassword}

  has_secure_password
  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
  BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end
  end
end
