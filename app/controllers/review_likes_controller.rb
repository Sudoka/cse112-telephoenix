class ReviewLikesController < ApplicationController
	respond_to:html

	before_filter :login_required, :only=>['new','create']
  
  def index
    @like = ReviewLike.all
  end

  def show
    @like = ReviewLike.find(params[:id])
  end

=begin
  def new
    @review = ReviewLike.find(params[:review_id])
    @user = current_user
    @like = @review.review_likes.build
    @like.user = @user
    @like.like = params[:value]
  end
=end


  def create
   
    #search for where this user and if it exist where it works..
    review = Review.find(params[:review_id])
    review_like=ReviewLike.where(:user_id =>current_user.id, :review_id => review.id )
    if review_like.empty? 
        if params[:value]=="like"
           review.num_likes = review.num_likes+1
           review.save!
           review_like = review.review_like.build
           review_like.value = params[:value]        
           review_like.user = current_user
           review_like.save!
        else
           review.num_dislikes = review.num_dislikes+1
           review.save!
           review_like = review.review_like.build
           review_like.value = params[:value]
           review_like.user = current_user
           review_like.save!
        end
    end
    redirect_to phone_path(review.phone)
    #@user = current_user
  end

end


