class WordsController < ApplicationController
  def show
    @lesson = Lesson.find(params[:lesson_id])
    @words = @lesson.words
  end
end
