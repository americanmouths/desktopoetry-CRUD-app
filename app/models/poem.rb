class Poem < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  def self.valid_params?(params)
    return !params[:title].empty? && !params[:content].empty? && !params[:date].empty? 
  end

end
