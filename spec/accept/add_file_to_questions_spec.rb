require_relative 'accept_helper'

feature 'Add file to question', %q{
  In order to illustrate my question
  As an question's author
  I'd like to be able to attach files
} do

  given!(:user) { create(:user) }

  background do
    sign_in(user)
    visit new_question_path
  end

  scenario 'User adds file when ask question', js: true do
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text'
    attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
    click_on 'Create'

    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/rails_helper.rb'
  end
end