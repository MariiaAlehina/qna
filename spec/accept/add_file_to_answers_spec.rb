require_relative 'accept_helper'

feature 'Add file to answer', %q{
  In order to illustrate my answer
  As an answer's author
  I'd like to be able to attach files
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'User adds file when write answer', js: true do
    fill_in 'Your answer', with: 'My answer'
    attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
    click_on 'Create'

    within'.answers' do
    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/rails_helper.rb'
    end
  end
end