class User < ActiveRecord::Base
  validates_presence_of :username, :password, :email
  has_secure_password
  has_many :poems
  has_many :categories

  def self.valid_params?(params)
   return !params[:username].empty? && !params[:password].empty? && !params[:email].empty?
 end

 def slug
   self.username.downcase.gsub(" ", "-")
 end

 def self.find_by_slug(slug)
   User.all.find{|user| user.slug == slug}
 end

end
