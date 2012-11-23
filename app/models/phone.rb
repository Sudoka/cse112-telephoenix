class Phone < ActiveRecord::Base
  has_many :tags
  has_many :ratings
  has_many :reviews
  attr_accessible :id, :name, :brand, :imgurl
 


  def self.search (search)
  	find(:all, :select => "Phones.id, name, brand", :from => "Tags, Phones", :conditions => ['value LIKE ? AND phone_id = Phones.id', "%" + search + "%"]) +
  	find(:all, :conditions => ['name LIKE ?', search]) +
    find(:all, :conditions => ['brand LIKE ?', search])
  end
  
  def self.phones_on_page (args={})
      sort_by = args[:sort_by]
      current_page = args[:current_page]
      num_per_page = args[:num_per_page]
     
      start = (current_page-1)*num_per_page+1
      tail = [self.count, current_page*num_per_page].min
      
      phones = self.sort_by(sort_by)
      phones[start .. tail]
      
  end

  def self.sort_by (attr)
      phones= self.all;
     if attr== "brand" || attr == :brand  
      phones.sort {|p1,p2| p1.brand.downcase<=>p2.brand.downcase}      
     elsif attr== "rating" || attr == :rating
      phones.sort {|p1,p2| 
         rating_1 = (p1.overallRatings =="NA") ? 0 : p1.overallRatings
         rating_2 = (p2.overallRatings =="NA") ? 0 : p2.overallRatings
      
         rating_2<=>rating_1
      } 
     else
      self.all             
     end
     
  end
  
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
	return (total>0) ? overall/total : ("NA")
  end

  def proRating()
    overall = 0
    total = 0
    ratings.each do |rating|
      if !rating.number_reviews
        overall += rating.rating
        total += 1
      end
    end
    return (total>0) ? overall/total : ("NA")
  end

  def userRating()
    overall = 0
    total = 0
    ratings.each do |rating|
      if rating.number_reviews
        overall += rating.rating*rating.number_reviews
        total += rating.number_reviews
      end
    end
    reviews.each do |review|
      overall += review.rating*10
      total += 1
    end
    return (total>0) ? overall/total : ("NA")
  end

end
