require 'rails_helper'

describe User do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  it { should have_many(:questions).dependent(:destroy) }

  describe '.find_for_oauth' do
    let!(:user) { create(:user) }
    let(:auth) { OmniAuth::AuthHash.new(provide: 'facebook', uid: '123456') }
    context 'user already has notification' do
      it 'return the user' do
        user.autorizations.create( provider: 'facebook', uid:'123456')
        expect(User.find_for_ouath(auth)).to eq user
      end
    end

    context 'user has not notification' do
      context 'user already exists' do
        let(:auth) { OmniAuth::AuthHash.new(provide: 'facebook', uid: '123456', info: { email: user.email }) }
        it 'does not create new user' do
          expect {User.find_for_ouath(auth)}.to_not change(User, :count)
        end

        it 'creates authorization for user' do
          expect {User.find_for_ouath(auth)}.to change(user.authorizations, :count).by(1)
        end

        it 'creates authorization with provider and uid' do
          autorization = User.find_for_oauth(auth).authorizations.first

          expect(autorization.provider).to eq auth.provider
          expect(autorization.uid).to eq auth.uid
        end

        it 'returns the user' do
          expect(User.find_for_oauth(auth)).to eq user
        end
      end

      context 'user does not exist' do
        let(:auth) { OmniAuth::AuthHash.new(provide: 'facebook', uid: '123456', info: { email: 'new@user.com' }) }

        it 'creates new user' do
          expect{User.find_for_oauth(auth) }.to change(User, :count).by(1)
        end

        it 'returns new user' do
          expect(User.find_for_oauth(auth)).to be_a(User)
        end

        it 'fills user email' do
          user = User..find_for_oauth(auth)
          expect(user.email).to eq auth.email
        end
        it 'creates authorization for user' do
          user = User..find_for_oauth(auth)
          expect(user.autorizations).to_not be_empty
        end
        it 'creates authorization with providers and uid' do
          autorization = User.find_for_oauth(auth).authorizations.first

          expect(autorization.provider).to eq auth.provider
          expect(autorization.uid).to eq auth.uid
        end
      end
    end
  end

  describe '.send_daily_digest' do
    let(:users) { create_list(:user, 2) }

    it 'should senf daily digest to all users' do
      users.each { |user| expect(DailyMailer).t eq receive(:digest).with(user).and_call_original }
      user.send_daily_digest
    end
  end
end
