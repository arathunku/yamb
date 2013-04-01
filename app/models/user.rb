class User < ActiveRecord::Base
  before_save :create_remember_token
  before_save { |user| user.email.downcase! }
  before_validation :create_username

  validates :email, presence:   true,
                    uniqueness: { case_sensitive: false }
  validates :username, uniqueness: { case_sensitive: false },
                       length: {minimum: 3, maximum: 128}
  


  def change_username(username)
    self.update_attributes(username: username)
  end

  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    def create_username
      self.username ||= self.email.split("@")[0]
    end
end
