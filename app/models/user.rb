class User < ApplicationRecord
  attr_writer :login
  PASSWORD_REQUIREMENTS = /\A 
  (?=.{8,})
  (?=.*\d)
  (?=.*[a-z])
  (?=.*[A-Z])
  (?=.*[[:^alnum:]])
  /x
  validates :password,format: PASSWORD_REQUIREMENTS
  #validates :password, presence: true, length: { minimum: 6, maximum: 128 }, password: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, authentication_keys: [:login]
  has_many :posts


  def login
    @login || username || email
  end

  def self.find_for_database_authentication( warden_conditions)
        conditions = warden_conditions.dup
      if(login = conditions.delete(:login))
                where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value",
                  { value: login.downcase}]).first
      elsif conditions.has_key?(:username) || conditions.has_key?(:email)
        where(conditions.to_h).first
      end
  end
  
 after_create :send_welcome
 private
  def send_welcome
     UserMailer.send_welcome(self).deliver_now
  end
end
