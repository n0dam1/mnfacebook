class CommentsController < ApplicationController
  before_action :set_comment, only:[:destroy, :edit, :update]

  def create
    @comment = current_user.comments.build(comment_params)

    respond_to do |format|
      if @comment.save
        format.js { render :index }
      else
        format.html { render :index }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @comment.destroy
        format.js { render :index }
      else
        format.html { render :index }
      end
    end
  end

  def edit
  end

  def update
    @topic = @comment.topic
    @comment.update(comment_params)
    redirect_to topic_path(@topic), notice: "コメントを更新しました！"
  end


  private

  def comment_params
    params.require(:comment).permit(:topic_id, :content)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

end
