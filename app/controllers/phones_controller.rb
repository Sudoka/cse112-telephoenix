class PhonesController < ApplicationController
  def index
     
    @num_per_page = 15
    @num_all  = Phone.count
    @num_pages = (@num_all.to_f/@num_per_page).ceil
  
    @sort_by = params[:sort].nil? ?   :brand  :  params[:sort][:word].downcase
    @current_page = params[:page].nil? ?  1 : params[:page].to_i 
    @brands_all = params[:all_brands].nil? ? 0 : params[:all_brands].to_i   
    @brands_params = params[:brands].nil? ?  {} : params[:brands]
    @os_params = params[:os].nil? ? {} : params[:os]
    @ratings_params = params[:ratings].nil? ? {} : params[:ratings]
   
    ####fetch data: @sort_by is "brand"/"rating" 
    @phones = Phone.phones_on_page :sort_by => @sort_by, :current_page => @current_page, :num_per_page => @num_per_page 
    
    ####                 sort
    @select = []
    @select[0] = @sort_by.capitalize
    @select[1] = @sort_by=="brand" ? "Rating" : "Brand"
    ####                 pagination
    @pages_bar = []
    @pages_bar[1] = 1
    i = 1
    if @current_page<=4
       while i <= @current_page
          @pages_bar[i] = i
          i = i+1
       end
    else
       @pages_bar[2] = "..."
       @pages_bar[3 .. 4] = [@current_page-1, @current_page]
       i = 5
    end
    if @current_page< @num_pages-1
       @pages_bar[i .. i+2] = [@current_page+1, "...", @num_pages]
    elsif @current_page< @num_pages
       @pages_bar[i] = @current_page+1
    end 
    ####                     right column     
    ##             brands 
    brands = Phone.select("distinct brand")
    @brands = []
    brands.each_index {|i| @brands[i] = brands[i].brand}
    if @brands_all == 0
       @brands = @brands[1 .. 7] 
       @brands_see = "See all brands"
       @brands_all = 1
    else 
       @brands_see = "See fewer brands"
       @brands_all = 0
    end
    @brands_checked = words_checked(@brands, @brands_params)
        
    ##             operating system
    @os =["Android", "BlackBerry", "Brew", "IOS", "Symbian", "Windows Phone 7"]
    @os_checked = words_checked(@os, @os_params)

    ##              rating
    @ratings =["4","3","2","1"]   
    
    @ratings_checked = words_checked(@ratings, @ratings_params)
   
  end

  def words_checked (words, words_params)
    words_checked = {}
    words.each do |w|
       words_checked[w] = words_params[w].nil? ? false : true
    end
    return words_checked
  end

  def show
    
    @phone = Phone.find(params[:id])
    @tags = Tag.find_all_by_phone_id(params[:id])
    @ratings = Rating.find_all_by_phone_id(params[:id])
    @reviews = Review.find_all_by_phone_id(params[:id])
    @overallrate = @phone.overallRatings()
    @prorating = @phone.proRating()
    @userrating = @phone.userRating()
  end

  def create
  	@phones = Phone.search(params[:name])
  end
end
