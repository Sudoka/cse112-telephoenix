class CommentsController < ApplicationController
  respond_to :html
  
  before_filter :login_required, :only=>['new','create']

  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @review = Review.find(params[:review_id])
    @user = current_user
    @comment = @review.comments.build
    @comment.user = @user
    respond_with(@comment)
  end

  def create
    @review = Review.find(params[:review_id])
    @user = current_user
    @comment = @review.comments.build(params[:comment])
    @comment.user = @user
    @comment.save
    redirect_to phone_review_path(@review.phone, @review)
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to moderators_path
  end


end
