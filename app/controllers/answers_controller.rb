class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :update]
  before_action :find_question
  before_action :find_answer, only: [:update]

  respond_to :js
  respond_to :json, only: :create

  def create
    @answer = @question.answers.create(
        answer_params.merge(user: current_user)
    )
    redirect_to question_path(@question)
  end

  def update
    @answer.update(answer_params) if current_user.author_of?(@answer)
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end

  def find_answer
    @answer = @question.answers.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_atributes: [:file])
  end
end
