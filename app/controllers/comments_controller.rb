class CommentsController < ApplicationController
  load_and_authorize_resource
  acts_as_commentable
  
  def create
    commentable = Post.create
    comment = commentable.comments.create
    comment.title = "First comment."
    comment.comment = "This is the first comment."
    comment.save
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to ...
  end

  def comment_params
    params.require(:comment).permit(:title, :comment, :user_id, :shop_id)
  end

end