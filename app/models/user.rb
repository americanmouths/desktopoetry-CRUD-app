class User < ActiveRecord::Base
  validates_presence_of :username, :password, :email
  has_secure_password
  has_many :poems
  has_many :categories

  def self.valid_params?(params)
   return !params[:username].empty? && !params[:password].empty? && !params[:email].empty?
 end
 
end
