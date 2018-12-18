class AnswersController < ApplicationController
  # before_action :find_question

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params)
  end

  # def destroy
  #   @answer = @question.answers.find(params[:id])
  #   @answer.destroy if current_user.author_of?(@answer)
  #   redirect_to @question
  # end

  private

  # def find_question
  #   @question = Question.find(params[:question_id])
  # ends

  def answer_params
    params.require(:answer).permit(:body)
  end
end
