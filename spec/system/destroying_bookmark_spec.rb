require 'rails_helper'

RSpec.describe "visiting edit bookmark" do
  
  let!(:bookmark) {
    create(:bookmark)
  }
  
  it "destroying bookmark" do
    visit(root_path)
    click_on('Destroy')

    page.accept_alert
    
    expect(page).to have_content('Bookmark was successfully destroyed.')
    expect(page.all('table.table tbody tr').size).to eq 0
  end
end