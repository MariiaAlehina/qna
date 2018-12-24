class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :update]
  before_action :find_question
  before_action :find_answer, only: [:update]

  def create
    @answer = @question.answers.create(
        answer_params.merge(user: current_user)
    )
    redirect_to @question
    # @answer = @question.answers.build(answer_params)

    # # respond_to do |format|
    #   if @answer.save
    #     redirect_to question_path
    #     # format.html { render partial: 'questions/answers', layout: false }
    #     # format.json { render json: @answer }
    #   else
    #     redirect_to questions_path
    #     # format.html { render text: @answer.errors.full_messages.join("\n"), status: :unprocessable_entity }
    #     # format.json { render text: @answer.errors.full_messages, status: :unprocessable_entity }
    #   end

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
