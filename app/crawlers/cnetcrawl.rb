#Script is able to crawl CNET professional reviews
class CNETCrawl
  
  #Load required libraries
  require 'nokogiri'
  require 'open-uri'
  
  #Get the Source object from the DB
  source = Source.find_by_name(:cnet)

  #Set and Load CNET URL
  url = "http://reviews.cnet.com/4566-6454_7-0-0.html?rpp=30"
  doc = Nokogiri::HTML(open(url))
  
  #Scrape all phones and their ratings
  phones = doc.xpath('//div[@class="prodInfo"]/a/h3/text()[1]')
  rates = doc.xpath('//div[@class="prodRate"]/div/a/@data-tiptitle')
  
  #Break down the data and add to DB
  phones.each do |p|
    p = p.to_s.strip
    brand = p[0,p.index(" ")]
    name = p[p.index(" ")+1,p.length]

    phone = Phone.find_or_create_by_name_and_brand(name, brand)
    
  end
end
