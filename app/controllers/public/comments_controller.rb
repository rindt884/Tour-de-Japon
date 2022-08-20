class Public::CommentsController < ApplicationController
    
  def create
    @post = Post.find(params[:post_id])
    comment = current_customer.comments.new(comment_params)
    comment.post_id = @post.id
    comment.save
    render :comments
    # redirect_to public_post_path(@post)
  end

  def destroy
    Comment.find_by(id: params[:id]).destroy
    @post = Post.find(params[:post_id])
    render :comments
    # redirect_to public_post_path(params[:post_id])
  end
  
  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end