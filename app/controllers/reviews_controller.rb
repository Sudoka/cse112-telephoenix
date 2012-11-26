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
    if Review.find_by_phone_id_and_user_id(@phone, @user) != nil
      flash[:warning] = "You can only write one review per phone"
      redirect_to phone_path(@phone)
    else
      @review = @phone.reviews.build
      @review.user = @user
      respond_with(@review)
    end
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
<<<<<<< HEAD
    @review = Review.find(params[:id])
    if can_edit(@review.user)
      respond_with(@review)  
    else
      flash[:warning] = "You can only write one review per phone"
      redirect_to phone_review_path(@review.phone, @review)
    end
  end

  def update
    @review = Review.find(params[:id])
    @review.update_attributes!(params[:review])
    redirect_to phone_review_path(@review.phone, @review)
  end

=======
    @phone = Phone.find(params[:phone_id])
    @user = current_user
  end


  def destroy
    Comment.find(params[:id]).destroy
    redirect_to moderators_path
  end


>>>>>>> c1b0b56261c86ae4788ef0bd32ab2ab1cd405ec6
end
