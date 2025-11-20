class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find_by(id: params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @post 
    else
      redirect_to @post, alert: "Comment cannot be blank."
    end
  end

  
  def destroy
    @comment = current_user.comments.find_by(id: params[:id])

    unless @comment
      redirect_back fallback_location: root_path, alert: "Comment not found."
      return #required because redirect_back doesnt return 
    end

    unless @comment.user == current_user
      redirect_to @comment.post, alert: "You are not authorized to delete this comment."
      return
    end

    if @comment.destroy
      redirect_to @comment.post, notice: "Comment deleted successfully."
    else
      redirect_to @comment.post, alert: "Something went wrong. Could not delete comment."
    end
  end

  private 

  def comment_params
    params.require(:comment).permit(:body)
  end
end
