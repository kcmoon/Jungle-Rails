class User < ApplicationRecord

  has_secure_password

  validates :password, presence: true
  validates_length_of :password, minimum: 6
  validates :password_confirmation, presence: true
  validates :email, presence: true
  validates_uniqueness_of :email, :case_sensitive => false
  validates :first_name, presence: true
  validates :last_name, presence: true


  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.strip.downcase) || User.find_by_email(email.strip.upcase)
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end

end
