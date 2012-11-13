class ReviewsController < ApplicationController
  respond_to :html
  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    @phone = Phone.find(params[:phone_id])
    @user = User.find(1)
    @review = @phone.reviews.build
    @review.user = @user
    respond_with(@review)
  end

  def create
    @phone = Phone.find(params[:phone_id])
    @user = User.find_by_username('Suckboy')
    @review = @phone.reviews.build(params[:review])
    @review.user = @user
    @review.save
    redirect_to phone_path(@phone)
  end

end
