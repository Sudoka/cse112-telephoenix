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
  overall = 0
  total = 0
	ratings.each do |rating|
    if !rating.number_reviews
      overall += rating.rating*10
      total += 10
    else
		  overall += rating.rating*rating.number_reviews
      total += rating.number_reviews
    end
	end
  reviews.each do |review|
    overall += review.rating*10
    total += 1
  end
	return (total>0) ? overall/total : (nil)
  end
#=end

end
