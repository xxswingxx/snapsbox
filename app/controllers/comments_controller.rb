class CommentsController < InheritedResources::Base
  nested_belongs_to :button
  
  def create
  	button = current_team.buttons.find params[:button_id]
    @comment = button.comments.build(comment_params)
    @comment.save
    redirect_to button
  end

  private
  def comment_params
  	params.require(:comment).permit(:body).merge(user: current_user)
  end
end
