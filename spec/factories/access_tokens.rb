FactoryBot.define do
  factory :access_token, class: Doorkeeper::Application do
    application { create(:oauth_application) }
    resource_owner_id { create(:user).id }
  end
end
