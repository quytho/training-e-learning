class PracticesController < ApplicationController
  before_action :get_lesson

  def create
    practice = current_user.practices.find_by(lesson_id: @lesson.id)

    if practice.blank?
      practice =  Practice.new(practice_params)
    elsif practice.score < params[:score].to_i
      practice.score = params[:score]
    end

    if practice.save
      flash[:success] = "Your results have been saved."
    else
      flash[:danger] = "Something went wrong! Try again."
      redirect_to practice_learning_index_path(lesson_id: @lesson.id)
    end
  end

  private
    def get_lesson
      @lesson = Lesson.includes(:words)
        .find_by_id(params[:lesson_id])
      if @lesson.blank?
        flash[:danger] = "The lesson is not available"
        redirect_to courses_path
      end
    end

    def practice_params 
      defaults = { user_id: current_user.id }
      params.permit(:score, :lesson_id, :user_id).reverse_merge(defaults)
    end
end
