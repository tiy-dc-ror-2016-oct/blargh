class MicroPostsController < ApplicationController
  before_action :authenticated!, only: :new
  load_and_authorize_resource

  def authenticated!
    redirect_to "/" unless current_user
  end

  def index
    @micro_posts = MicroPost.all
    render :index
  end

  def new
    @micro_post = MicroPost.new(user_id: current_user.id)
    # authorize! :create, @micro_post
  end

  def create
    @micro_post = MicroPost.new(micro_post_params)

    if @micro_post.save
      redirect_to "/micro_posts", flash: { warning: "Micro Post created!"}
    else
      render :new
    end
  end

  def edit
    @micro_post = MicroPost.find(params["id"])
  end

  def update
    @micro_post = MicroPost.find(params["id"])
    if @micro_post.update(micro_post_params)
      redirect micro_posts_path
    else
      render :edit
    end
  end

  def destroy
    @micro_post = MicroPost.find(params["id"])
    @micro_post.destroy
    redirect_to micro_posts_path
  end

  def download
    @micro_post = MicroPost.find(params["id"])

    render json: @micro_post
  end

  def micro_post_params
    params.require(:micro_post).permit(:title, :content, :user_id)
  end
end
