class CommentsController < ApplicationController
  
  def new
    @comment = Comment.new
  end

  def create
    @shop = Shop.find(params[:shop_id])
    @comment = @shop.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
    redirect_to @shop
  end


  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to(shop_path)
  end

private
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:title, :comment)
  end

end