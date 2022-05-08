class Admin::User < Admin::ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, allow_nil: true, length: { minimum: 12 }, format: { with: /(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])/ }

  before_validation do
    self.email = email.downcase.strip
  end
end
