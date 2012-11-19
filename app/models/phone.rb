class Phone < ActiveRecord::Base
  has_many :tags
  has_many :ratings
  has_many :reviews
  attr_accessible :id, :name, :brand

  def self.search (search)
  	find(:all, :select => "Phones.id, name, brand", :from => "Tags, Phones", :conditions => ['value LIKE ? AND phone_id = Phones.id', "%" + search + "%"]) +
  	find(:all, :conditions => ['name LIKE ?', search])
  end
#=begin
  def overallRatings()
	ratings.each do |rating|
		overall += rating
	end
	
  end
#=end

end
