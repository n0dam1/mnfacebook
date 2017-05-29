class TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic, only: [:edit, :update, :destroy]

  def index
    @topics = Topic.all
  end

  def create
    @topic = Topic.new(topics_params)
    @topic.user_id = current_user.id
    @topic.save
    redirect_to topics_path
  end

  def new
    @topic = Topic.new
  end

  def edit
  end

  def update
    @topic.update(topics_params)
    redirect_to topics_path
  end

  def destroy
    @topic.destroy
    redirect_to topics_path
  end

  private
    def topics_params
      params.require(:topic).permit(:content)
    end

    def set_topic
      @topic = Topic.find(params[:id])
    end

end
