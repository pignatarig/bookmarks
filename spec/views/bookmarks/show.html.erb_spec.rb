require 'rails_helper'

RSpec.describe "bookmarks/show", type: :view do
  before(:each) do
    @bookmark = assign(:bookmark, create(:bookmark))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/#{attributes_for(:bookmark)[:title]}/)
    expect(rendered).to match(/#{attributes_for(:bookmark)[:form_tags]}/)
  end
end
