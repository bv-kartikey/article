class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @post, notice: "Comment added!"
    else
      redirect_to @post, alert: "Comment cannot be blank."
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    
    # Optional: only allow user or admin to delete
    if @comment.user == current_user
      @comment.destroy
      redirect_to @comment.post, notice: "Comment deleted."
    else
      redirect_to @comment.post, alert: "Not authorized!"
    end
  end

  private 

  def comment_params
    params.require(:comment).permit(:body)
  end
end
