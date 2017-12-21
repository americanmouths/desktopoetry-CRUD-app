class Category < ActiveRecord::Base
  has_many :poems
  belongs_to :user

  def self.valid_params?(params)
   return !params[:category][:name].empty?
 end

end
