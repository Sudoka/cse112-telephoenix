class StaticPagesController < ApplicationController
  def about
  end

  def contact
  end

  def home
    @recentReviews = Review.limit(5)
    @featuredPhone = Phone.first(:offset => rand(Phone.count))
  end
end
