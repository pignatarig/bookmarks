require 'rails_helper'

RSpec.describe "visiting home" do
  let!(:bookmark) {
    create(:bookmark)
    create(:bookmark)
  }
  
  it "should be a table with two rows" do
    visit(root_path)
    expect(page.all('table.table tbody tr').size).to eq 2
  end
end