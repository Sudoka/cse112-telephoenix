class ReviewsController < ApplicationController
  respond_to :html
  
  before_filter :login_required, :only=>['new','create']

  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
    @comments = Comment.find_all_by_review_id(params[:id])
  end

  def new
    @phone = Phone.find(params[:phone_id])
    @user = current_user
    @review = @phone.reviews.build
    @review.user = @user
    respond_with(@review)
  end

  def create
    @phone = Phone.find(params[:phone_id])
    @user = current_user
    @review = @phone.reviews.build(params[:review])
    @review.user = @user
    @review.save
    redirect_to phone_path(@phone)
  end

  def edit
    @phone = Phone.find(params[:phone_id])
    @user = current_user
  end


  def destroy
    Comment.find(params[:id]).destroy
    redirect_to moderators_path
  end


end
