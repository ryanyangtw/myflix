class Video < ActiveRecord::Base

  validates_uniqueness_of :title

  belongs_to :category

end
