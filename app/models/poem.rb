class Poem < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  def self.valid_params?(params)
    return !params[:poems][:title].empty? && !params[:poems][:content].empty? && !params[:poems][:date].empty?
  end

end
