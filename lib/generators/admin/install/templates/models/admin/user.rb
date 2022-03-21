class Admin::User < Admin::ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates_format_of :email, with: /\A[^@\s]+@[^@\s]+\z/

  validates_length_of :password, minimum: 12, allow_nil: true
  validates_format_of :password, with: /(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])/, allow_nil: true, message: "might easily be guessed"

  before_validation do
    self.email = email.downcase.strip
  end
end
