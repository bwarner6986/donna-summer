class CommentsController < ApplicationController
  before_action :ensure_logged_in

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id 
    @comment.link_id = params[:link_id]
    if @comment.save
      redirect_to link_url(@comment.link_id)
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to new_session_url
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user_id = current_user.id 
      @comment.destroy
      redirect_to link_url(@comment.link_id)
    else 
      flash[:errors] = @comment.errors.full_messages 
      redirect_to new_session_url
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end