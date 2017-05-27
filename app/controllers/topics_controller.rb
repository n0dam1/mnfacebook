class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end

  def create
    @topic = Topic.create(topic_params)
    redirect_to topics_path
  end

  def new
    @topic = Topic.new
  end

  private
    def topic_params
      params.require(:topic).permit(:content)
    end

end
