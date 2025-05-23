class AdminUser < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, if: :new_record?

  def self.authenticate(email, password)
    admin = find_by(email: email)
    return nil unless admin
    admin.authenticate(password)
  end
end 