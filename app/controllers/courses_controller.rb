class CoursesController < ApplicationController
  before_action :get_course, except: [:index]
  before_action :logged_in_user, except: [:index, :show]
  def index
    @courses = Course.all
  end

  def show
  end

  def words
    @words = @course.words
    if(params[:filter] == 'learned')
      @words = Word.where(id: current_user.user_words.pluck(:word_id), course_id: @course.id)
    elsif(params[:filter] == 'unlearn')
      word_course = Word.where(course_id: @course.id)
      @words = word_course.where.not(id: current_user.user_words.pluck(:word_id))
    elsif(params[:filter] == 'all')
      @words
    else
      word_course = Word.where(course_id: @course.id)
      @words = word_course.where('en_word ILIKE ?', "#{params[:key]}%")
    end
  end

  private
    def get_course
      @course = Course.includes(:lessons)
        .find_by_id(params[:id])
      if @course.blank?
        flash[:danger] = "Could not found this course"
        redirect_to courses_path
      end
    end
end
