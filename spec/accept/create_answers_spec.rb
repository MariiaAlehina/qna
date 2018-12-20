require_relative 'accept_helper'

# require 'spec_helper'
# require 'acceptences/acceptences_helper'
feature 'User answer', %q{
  In order to exchange my knowledge
  As an authenticated user
  I want to be able to create answer
} do

  given!(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authenticated user create answer', js: true do
    sign_in(user)

    visit question_path(question)

    fill_in 'Your answer', with: 'My answer'
    click_on 'Create'

    expect(current_path).to eq  question_path(question)
    within '.answers' do
    expect(page).to have_content 'My answer'
    end
  end

  scenario 'User try to create invalid answer', js: true do
    sign_in user
    visit question_path(question)

    click_on 'Create'

    expect(page).to have_content "Answer's body can't be blank"
  end
end