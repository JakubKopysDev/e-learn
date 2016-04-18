class CommentsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @guide = Guide.find(params[:guide_id])
    @comment = @guide.comments.build(comment_params)
    @comment.user = current_user
    @comment.save
    respond_to do |format|
      format.html {
        flash[:notice] = "Commented!!"
        redirect_to :back
      }
      format.js
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.delete
    redirect_to :back
  end

  private

    def comment_params
      params.require(:comment).permit(:body, :user)
    end

end
