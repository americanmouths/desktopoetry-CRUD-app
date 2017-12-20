class Category < ActiveRecord::Base
  has_many :poems

  def self.valid_params?(params)
   return !params[:name].empty?
 end

end
