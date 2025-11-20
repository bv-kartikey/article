class PostsController < ApplicationController

# before action
before_action :authenticate_user!, except:[ :index, :show]
before_action :load_post, only: [:show, :edit, :update, :destroy]




# handlers

  def index
    @posts = Post.all
  end

  def show
  end
  
  def new
    @post= Post.new
  end
  
  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Post Deleted"
  end



  private 

  def load_post
    @post = current.posts.find_by(id: params[:id])

    if @post.nil?
      redirect_to posts_path, alert: "Page not founds"
    end
  end
  def post_params
    params.require(:post).permit(:title, :body)
  end

end
