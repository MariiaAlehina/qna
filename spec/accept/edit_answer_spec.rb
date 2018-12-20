require_relative 'accept_helper'

feature 'Answer editing', %q{
  In order to fix mistake
  As an author of answer
  I'd like at be able to edit my answer
} do

  given!(:user) { create(:user) }
  given(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question) }

  scenario 'Unauthenticated user try to edit question' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit'
  end

  describe 'Authenticated user' do
    before do
      sign_in user
      question_path(question)
    end

    scenario "sees link to edit" do
      within '.answer'do
        expect(page).to have_link 'Edit'
      end
    end

    scenario 'try to edit his question', js: true do
      click_on 'Edit'
      within '.answer' do
        fill_in 'Answer', with: 'edited answer'

      click_on 'Save'

      expect(page).to_not have_content answer.body
      expect(page).to have_content 'edited answer'
      expect(page).to_not have_selector 'textarea'
      end
    end

    # scenario "try to edit other user's question" do
    #   sign_in(new_user)
    #   visit question_path(question)
    #
    #   within '.answers' do
    # #     expect(page).to_not have_css '.edit-answer-link'
    # #   end
    # end
  end
end