require 'rails_helper'

RSpec.describe "visiting edit bookmark" do
  
  let!(:bookmark) {
    create(:bookmark)
  }
  
  it "editing bookmark" do
    visit(root_path)
    click_on('Edit')
    
    fill_in('Title', with: 'Bookmark Edited')
    fill_in('Url', with: 'https://google.com/edit')
    fill_in('bookmark_form_tags', with: 'google, vehiculum, new_tag')
    click_on('Update Bookmark')
    
    expect(page).to have_content('Bookmark was successfully updated.')
    expect(page).to have_content('Bookmark Edited')
    expect(page).to have_content('https://google.com/edit')
    expect(page).to have_content('google, vehiculum, new_tag')
  end
end