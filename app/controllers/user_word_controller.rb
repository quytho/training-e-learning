class UserWordController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @user_word = UserWord.new(user_word_params)
    if @user_word.save
      flash[:success] = "Done Successfully"
      redirect_to request.referrer
    else
      flash[:danger] = "Done Fail"
      redirect_to request.referrer
    end
  end

  private 
    def user_word_params 
      params.permit(:word_id, :user_id)
    end
end
