FactoryBot.define do
  factory :question do
    title 'Title'
    body 'Body'
    user
    # association :user, factory: :user
  end

  factory :invalid_question, class: "Question" do
    title nil
    body nil
  end
end
