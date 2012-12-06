class PhonesController < ApplicationController
  def index
    @num_params = params[:show].nil? ?  {} : params[:show]
    @num_per_page = params[:show].nil? ?  20 : params[:show][:number].to_i
    
  
    @sort_by_params = params[:sort_by].nil? ?   {:word => :brand}  :  params[:sort_by]
 
    @current_page = params[:page].nil? ?  1 : params[:page].to_i 
  
    @brands_params = params[:brands].nil? ?  {} : params[:brands]
    @os_params = params[:os].nil? ? {} : params[:os]
    @ratings_params = params[:ratings].nil? ? {} : params[:ratings]
 
    ####fetch data: @sort_by is "brand"/"rating" 
    sort_by = params[:sort_by].nil? ?   "brand" : params[:sort_by][:word].downcase
    brands = @brands_params.keys
    os = @os_params.keys
    rating = @ratings_params.keys.empty? ? 0 : @ratings_params.keys[0].to_i*20   #make rating 0-100
    
    phones = Phone.phones_choosen :brands => brands, :os => os, :rating => rating, :sort_by => sort_by
   # debugger
    @num_all  = phones.count
    @num_pages = (@num_all.to_f/@num_per_page).ceil
    
    @phones = Phone.phones_on_page phones, @current_page, @num_per_page
    ####                 sort
    @select = []
    @select[0] = sort_by.capitalize
    @select[1] = sort_by=="brand" ? "Rating" : "Brand"
    ####                 items/page
    @select_num = []
    temp = [10, 20, 30]
    @select_num[0] = @num_per_page
    temp.each do |num| 
      if num!= @num_per_page
           @select_num << num
      end
    end
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
    temp = Phone.select("distinct brand")
    brands = []
    temp.each_index {|i| brands[i] = temp[i].brand}
    @brands1 = brands[0 .. 4]
    @brands2 = brands[5 .. -1]  
    @brands_checked = words_checked(brands, @brands_params)
        
    ##             operating system
    @os =["Android", "BlackBerry", "Brew", "IOS", "Symbian", "Windows Phone"]
    @os_checked = words_checked(@os, @os_params)

    ##              rating
    @ratings =["4","3","2","1"]      
    @ratings_checked = words_checked(@ratings, @ratings_params)
    ####              number of phones if checked
    @num_if_checked = {}
    @num_if_checked = Phone.num_if_checked(phones, brands, @os, @ratings)
    ##             number of reviews
    
  
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
