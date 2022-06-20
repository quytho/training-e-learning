class CommentsController < ApplicationController
  # before_action :logged_in_user, except: %i[index show]

  # def create
  #   # render json: params
  #   @course = Course.find(params[:course_id])
  #   @comment = @course.comments.create(comment_params)

  #   if @comment.save 
  #       flash[:success] = "Comment posted!"
  #       redirect_to request.referrer || root_url
  #   else
  #       render 'static_pages/home'
  #   end
  # end

  # def new
  #   @course = Course.find(params[:course_id])
  #   @comment = @course.comments.create(parent_id: params[:parent_id])

  # end

  # def edit
  #   @comment = Comment.find(params[:id])
  # end

  # def update
  #   @comment = Comment.find(params[:id])
  #   if @comment.update(comment_params)
  #       flash[:success] = "Comment updated"
  #       redirect_to @comment.course
  #   else
  #       render 'edit'
  #   end
  # end

  # def destroy
  #   @comment = Comment.find(params[:id])
  #   @comment.destroy
  #   flash[:success] = "Comment deleted"
  #   redirect_to request.referrer || root_url
  # end

  # private
  #   def comment_params
  #     params.require(:comment).permit(:body, :parent_id, :course_id, :user_id)
  #   end

  def create
    # render json: params
    @course = Course.find(params[:course_id])
    @comment = @course.comments.create(comment_params)
    byebug
    if @comment.save
      flash[:success] = "Comment successfully"
      redirect_to request.referrer || root_url
    else
      flash.now[:danger] = "error"
    end
  end

  def new
    @course = Course.find(params[:course_id])
    @comment = @course.comments.create(parent_id: params[:parent_id])
  end
  
  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      # Handle a successful update.
      flash[:success] = "Updated successfully"
      redirect_to request.referrer || root_url
    else
      render 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end
  private
    def comment_params
      params.require(:comment).permit(:body, :parent_id,:course_id,:user_id)
    end
end
