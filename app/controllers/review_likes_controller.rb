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
    debugger
    @review = ReviewLike.find(params[:review_id])
    @user = current_user
    @like = @review.review_likes.build
    @like.user = @user
    @like.like = params[:value]
  end

  def create
    @review = ReviewLike.find(params[:review_id])
    @user = current_user
    @like = @like.comments.build(params[:like])
    @like.user = @user
    @like.like = params[:value]
    @like.save
    redirect_to phone_path(@review.phone)
  end

end


