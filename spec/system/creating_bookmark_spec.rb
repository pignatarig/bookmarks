require 'rails_helper'

RSpec.describe "visiting new bookmark" do
  
  it "creating bookmark" do
    visit(root_path)
    click_on('New Bookmark')
    fill_in('Title', with: 'Bookmark Title')
    fill_in('Url', with: 'https://google.com/creating')
    fill_in('bookmark_form_tags', with: 'google, vehiculum')
    click_on('Create Bookmark')
    
    expect(page).to have_content('Bookmark was successfully created.')
    expect(page).to have_content('Bookmark Title')
    expect(page).to have_content('https://google.com/creating')
    expect(page).to have_content('google, vehiculum')    
  end
end