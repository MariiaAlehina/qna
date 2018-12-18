require 'rails_helper'

describe AnswersController do
  let(:question) { create(:question) }

  describe 'POST #create' do

    context 'with valid attributes' do

      it 'saves the new question in the database' do
        expect { post :create, params: { answer: attributes_for(:answer), question_id: question, format: :js } }.to change{ question.answers.count }.by(1)
      end

      it 'render create template' do
        post :create , params: { answer: attributes_for(:answer),  question_id: question, format: :js }
        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do

      it 'doesnt save answer in db' do
        expect { post :create, params: {  answer: attributes_for(:invalid_answer), question_id: question, format: :js } }.to_not change(Answer, :count)
      end

      it 'render create template' do
        post :create , params: { answer: attributes_for(:invalid_answer),  question_id: question, format: :js }
        expect(response).to render_template :create
      end
    end
  end
end