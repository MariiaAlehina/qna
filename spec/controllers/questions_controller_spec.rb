require 'rails_helper'

describe QuestionsController do

  let(:question) { create(:question) }

  describe 'GET #index' do

    let(:questions) { create_list(:question, 2) }

    before { get :index }
     it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: {id: question} }

    it 'assigns the requested to @question' do
      expect(assigns(:questions)).to eq(@question)
    end

    it 'assigns new answer for question'do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before do
      @user = create(:user)
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in @user
    end
    before { get :new }

    it 'assings a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'build new attachment for question' do
      expect(assigns(:question).attachments.first).to be_a_new(Attachment)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before do
      @user = create(:user)
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in @user
    end

    before { get :edit, params: { id: question } }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'render edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    before do
      @user = create(:user)
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in @user
    end

    context 'with valid attributes' do
      it 'saves the new question in the database' do
        expect { post :create, params: { question: attributes_for(:question[:id]) }}.to change{ Question.count }.by(1)
      end

      it 'redirects to show view' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      it 'not saves the new question in the database' do
        expect { post :create, params: { question: attributes_for(:invalid_question) }}.to_not change(Question, :count)
      end

      it 're-render new view' do
        post :create, params: { question: attributes_for(:invalid_question) }
        expect(response).to render_template :new
      end
    end
  end


  describe 'PATCH #update' do
    before do
      @user = create(:user)
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in @user
    end

    context 'with valid attributes' do
      it 'assigns the requested question to @question' do
        patch :update, params: { id: question, question: attributes_for(:question) }
        expect(assigns(:question)).to eq question
      end

      it 'change question attributes' do
        patch :update, params: { id: question, question: { title: 'new title', body: 'new body' }}
        question.reload
        expect(question.title).to eq 'new title'
        expect(question.body).to eq 'new body'
      end

      it 'redirects to updated question' do
        patch :update, params: { id: question, question: attributes_for(:question) }
        expect(response).to redirect_to question
      end
    end

    context 'with invalid attributes' do
      before { patch :update, params: { id: question, question: { title: nil, body: 'new body' }} }

      it 'does not change question attributes' do
        question.reload
        expect(question.title).to eq 'Title'
        expect(question.body).to eq 'Body'
      end

      it 're-render edit view' do
        expect(response).to render_template :edit
      end
    end
  end

    describe 'DELETE #destroy' do
      let(:questions) { create_list(:question, 2) }
      before do
        @user = create(:user)
        @request.env['devise.mapping'] = Devise.mappings[:user]
        sign_in @user
      end
      before { question }
      it 'delete question' do
        expect { delete :destroy, params: { id: question} }.to change(Question, :count).by(-1)
      end

      it 'redirect to index view' do
      delete :destroy, params: { id: question}
      expect(response).to redirect_to questions_path
      end
    end
  end
