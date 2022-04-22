class LessonsController < ApplicationController
  before_action :get_lession, only: [:index]
  
  def index
  end

  def test
  end
  
  private
    def get_lession
      @lesson = Lesson.includes(:words)
        .find_by_id(params[:lesson_id])
      if @lesson.blank?
        flash[:danger] = "The lesson is not available"
        redirect_to courses_path
      end
    end
end
