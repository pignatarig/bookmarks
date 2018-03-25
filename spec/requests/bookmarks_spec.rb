require 'rails_helper'

RSpec.describe "Bookmarks", type: :request do
  describe "GET /bookmarks" do
    it "checks bookmarks index" do
      get bookmarks_path
      expect(response).to have_http_status(200)
    end
  end
  
  describe "GET /bookmarks/new" do
    it "checks new form" do
      get new_bookmark_path
      expect(response).to have_http_status(200)
    end
  end
end
