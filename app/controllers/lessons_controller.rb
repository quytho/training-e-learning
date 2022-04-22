class LessonsController < ApplicationController
  before_action :get_lesson
  
  def index
  end

  def create
    @words_ids = @lesson.words.map {|word| word.id}
    @words_userword_ids = UserWord.where(user_id: current_user.id).map {|word| word.word_id} || []
    @userword_attrs = (@words_ids - @words_userword_ids).map { |id| {:word_id => id, :user_id => current_user.id}}
    UserWord.bulk_insert(:word_id, :user_id, :created_at, :updated_at) do |worker|
      @userword_attrs.each do |attr|
        worker.add(attr)
      end
    end

    redirect_to learning_practice_path(lesson_id: @lesson.id)
  end

  def get_word
    render json: @lesson.words.select(:id, :en_word, :vi_word)
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
end
