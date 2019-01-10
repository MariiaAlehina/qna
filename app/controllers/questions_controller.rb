class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_question, only: [:show, :edit, :update, :destroy]
  # after_action :publish_question, only: [:create]
  before_action :build_answer, only: [:show]

  respond_to :html

  authorize_resource

  def index
    respond_with(@question = Question.all)
  end

  def show
    respond_with @question
  end

  def new
    respond_with(@question = Question.new)
  end

  def edit
  end

  def create
    @question = current_user.questions.new(question_params)
    flash[:notice] = "Your question successfully created." if @question.save
    respond_with @question
  end

  def update
    @question.update(question_params)
    respond_with @question
  end

  def destroy
    respond_with(@question.destroy)
  end

  private

  def build_answer
    @answer = @question.answers.build
  end

  def load_question
    @question = Question.find_by(id: [params[:id], params[:question_id]])
  end

  # def publish_question
  #   return if @question.errors.any?
  #   ActionCable.server.broadcast(
  #       'questions',
  #       ApplicationController.render(
  #         partial: 'questions/question',
  #         locals: {question: @question}
  #       )
  #   )
  # end

  def question_params
    params.require(:question).permit(:title, :body, attachments_atributes: [:file])
  end
end
