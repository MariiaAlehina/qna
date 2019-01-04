require 'rails_helper'

describe 'Profile API' do
  describe 'GET /me' do
    context 'unauthorized' do
      it 'returns 401 status if there is no access_taken' do
        get 'api/v1/profiles/me', format: :json
        expect(response.status).to eq 401
      end

      it 'returns 401 status if access_token is invalid' do
        get 'api/v1/profiles/me', format: :json, access_token: '1234'
        expect(response.status).to eq 401
      end
    end
  end

  context 'authorized' do
    let(:me) { create(:user) }
    let(:access_token) { create(:access_token) }

    before { get 'api/v1/profiles/me', format: :json, access_token: access_token.token }

    it 'returns 200 status' do
      expect(response).to be_success
    end

    it 'contains email' do
      expect(response.body).to be_json_eql(me.email.to_json).at_path('email')
    end

    it 'contain id' do
      expect(response.body).to be_json_eql(me.id.to_json).at_path('id')
    end
  end
end