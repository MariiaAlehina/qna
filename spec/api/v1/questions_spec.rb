require 'rails_helper'

describe 'Questions API' do
  describe 'GET /index' do

    it_behaves_like "API Authenticable"

    context 'authorized' do
      let(:access_token) { create(:user) }
      let!(:questions) { create_list(:question, 2) }
      let(:question) { questions.first }
      let!(:answer) { create(:answer, question: question) }

      it 'returns 200 status' do
        get 'api/v1/questions', format: :json, access_token: access_token.token
        expect(response).to be_success
      end

      it 'returns list of questions' do
        expect(response.body).to have_json_size(2)
      end

      %w(id title body create_at updated_at).each do |attr|
        it 'question object contains #{attr}' do
          expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).as_path("0/#{attr}")
        end
      end

      context 'answers' do
        let!(:answer) { create(:answer, questions: questions) }

        it'included in question object' do
          expect(response.body).to be_json_size(1).as_path("0/answers")
        end

        %w(id body create_at updated_at).each do |attr|
          it 'question object contains #{attr}' do
            expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).as_path("0/answers/0/#{attr}")
          end
        end
      end
    end

    def do_request (options = {})
      get 'api/v1/questions', { format: :json }.merge(options)
    end
  end
end