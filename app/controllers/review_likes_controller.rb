class ReviewLikesController < ApplicationController
	respond_to:html

	before_filter :login_required, :only=>['new','create']
  
  def index
    @like = ReviewLike.all
  end

  def show
    @like = ReviewLike.find(params[:id])
  end

  def new
<<<<<<< HEAD

=======
    debugger
>>>>>>> 006b62677e51d2321bf9c65f5d226190b44ab86b
    @review = ReviewLike.find(params[:review_id])
    @user = current_user
    @like = @review.review_likes.build
    @like.user = @user
    @like.like = params[:value]
  end

  def create
    review = Review.find(params[:review_id])
    review_like = review.review_like.build
    review_like.like = 1
    review_like.user = review.user
    review_like.save!
    
    #Sdebugger
    #@user = current_user  
    #@like.user = @user
    #@like.like = params[:value]
    #@like.save
    #debugger
    redirect_to phone_path(review.phone)
    @review = ReviewLike.find(params[:review_id])
    @user = current_user
    @like = @like.comments.build(params[:like])
    @like.user = @user
    @like.like = params[:value]
    @like.save
    redirect_to phone_path(@review.phone)
  end

end


