require 'rails_helper'

RSpec.describe "bookmarks/index", type: :view do
  before(:each) do
    assign(:bookmarks, {create(:site).url.to_s => [create(:bookmark), create(:bookmark)]})
  end

  it "renders a list of bookmarks" do
    render
    assert_select "tr>td", :text => attributes_for(:bookmark)[:title].to_s, :count => 2
    assert_select "tr>td", :text => attributes_for(:bookmark)[:url].to_s, :count => 2
  end
end
