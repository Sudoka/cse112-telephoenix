class Phone < ActiveRecord::Base
  has_many :tags
  has_many :ratings
  has_many :reviews
  attr_accessible :id, :name, :brand, :imgurl
 


  def self.search (search)
  	find(:all, :select => "Phones.id, name, brand", :from => "Tags, Phones", :conditions => ['lower(value) LIKE lower(?) AND phone_id = Phones.id', "%" + search + "%"]) +
    find(:all, :conditions => ['lower(name) LIKE lower(?)', "%" + search + "%"]) +
    find(:all, :conditions => ['lower(brand) LIKE lower(?)', search])
  end
  
  def self.phones_choosen (args={})
      ##disply para
      sort_by = args[:sort_by]
      ##filter  para
      brands = args[:brands]
      os = args[:os]
      rating = args[:rating]
      ##filter & sort      
      phones = self.filter_by_brand(brands)&self.filter_by_os(os)&self.filter_by_rating(rating)
      phones = self.sort_by(phones, sort_by)      
  end
  
  def self.phones_on_page (phones, current_page, num_per_page)
      start = (current_page-1)*num_per_page
      tail = [self.count-1, current_page*num_per_page-1].min 
          
      phones[start .. tail]
       
  end

  def self.filter_by_brand (brands)  # brands=["brand1", "brand2"]      
      phones = brands.empty? ?  self.all : self.where(:brand => brands)            
  end
  
  def self.filter_by_os (os) # os=['os1' , 'os2'], must be in an array
      phones = []
      if os.empty? 
        phones = self.all
      else 
        os.each do |s|
           phones = phones + Phone.includes(:tags).where('tags.value LIKE ?', "%#{s}%")
        end
      end 
      return phones        
  end
  
  def self.filter_by_rating (rating)  #rating fixnum 20,40,60,80
      phones = self.all
      phones.find_all { |p|
         r = (p.overallRatings=='NA') ?  0 : p.overallRatings 
         r >= rating
      }     
  end
  
  def self.sort_by (phones, key) 
      if key== "brand" || key == :brand  
      phones.sort {|p1,p2| p1.brand.downcase<=>p2.brand.downcase}      
      elsif key== "rating" || key == :rating
      phones.sort {|p1,p2| 
         rating_1 = (p1.overallRatings =="NA") ? 0 : p1.overallRatings
         rating_2 = (p2.overallRatings =="NA") ? 0 : p2.overallRatings
      
         rating_2<=>rating_1
      } 
      else 
      end
      
  end
 
  def self.num_if_checked (phones, brands, os, ratings) #rating are determined  '4', '3', '2', '1'
       ratings = ['4', '3', '2', '1']
       num = {}
       brands.each {|brand|  num[brand] = (filter_by_brand(brand)&phones).count }
       os.each {|s| num[s] = (filter_by_os([s])&phones).count }
       ratings.each {|rating| num[rating] = (filter_by_rating(20*rating.to_i)&phones).count }
     
 
       return num
  end      

=begin 

  def self.sort_by (key)
      phones= self.all;
     if key== "brand" || key == :brand  
      phones.sort {|p1,p2| p1.brand.downcase<=>p2.brand.downcase}      
     elsif key== "rating" || key == :rating
      phones.sort {|p1,p2| 
         rating_1 = (p1.overallRatings =="NA") ? 0 : p1.overallRatings
         rating_2 = (p2.overallRatings =="NA") ? 0 : p2.overallRatings
      
         rating_2<=>rating_1
      } 
     else
      self.all             
     end
     
  end

=end

def num_stars ()
  num = self.overallRatings()
  num = num=="NA" ?  0 : num/20.0
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
