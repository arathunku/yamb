# == Schema Information
#
# Table name: users
#
#  id             :integer          not null, primary key
#  username       :string(255)
#  email          :string(255)
#  remember_token :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  bio            :text
#  fullname       :string(255)
#

class User < ActiveRecord::Base
  before_save :create_remember_token
  before_save { |user| user.email.downcase! }
  after_create :create_username
  after_create :create_design

  has_one :design, dependent: :destroy
  has_many :posts, dependent: :destroy

  validates :email, presence:   true,
                    uniqueness: { case_sensitive: false }
  validates :username, uniqueness: { case_sensitive: false },
                       length: {maximum: 128}

  def change_username(username)
    return if username.nil?
    username.gsub!(/\s+/, "")
    unless username.empty?
      self.update_column(:username, username)
    end
  end

  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    def create_username
      change_username(self.id.to_s) unless self.username
    end

    def create_design
      Design.create(user_id: self.id)
    end
end
