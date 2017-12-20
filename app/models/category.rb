class Category < ActiveRecord::Base
  has_many :poems
end
