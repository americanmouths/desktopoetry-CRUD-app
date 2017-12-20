class User < ActiveRecord::Base
  validates_presence_of :username, :password, :email
  has_secure_password
  has_many :poems
end
