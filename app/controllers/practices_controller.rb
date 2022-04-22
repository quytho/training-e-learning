class PracticesController < ApplicationController
  before_action :get_lesson

  def index
  end

  def create
    practice = @lesson.practice
    if practice.blank?
      @practice =  Practice.new(practice_params)
      @practice.save
    elsif practice.score < params[:score].to_i
      practice.score = params[:score]
      practice.save
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
