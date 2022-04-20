class UserWordController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @user_words = UserWord.create(user_word_params)
    flash[:success] = "Done Successfully"
    redirect_to request.referrer
  end

  private 
    def user_word_params 
      params.permit(:word_id, :user_id)
    end
end
