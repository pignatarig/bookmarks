require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  it "is valid with title and url" do
    expect(build(:bookmark)).to be_valid
  end
  
  it "is not valid without title and url" do
    expect(Bookmark.new).to_not be_valid
  end
  
  it "is not valid without title" do
    expect(build(:bookmark, title: nil)).to_not be_valid
  end
  
  it "is not valid without url" do
    expect(build(:bookmark, url: nil)).to_not be_valid
  end
  
  it "create site if it's the first bookmark for that site" do
    bookmark = create(:bookmark)
    expect(bookmark.site.url).to eq 'https://www.google.com'
  end
  
  it "the URL is already stored in sites assign the site to the bookmark" do
    bookmark = create(:bookmark)
    bookmark = create(:bookmark, url: 'https://www.google.com/b')
    bookmark = create(:bookmark, url: 'https://www.google.com/c')
    
    expect(Site.where(url: 'https://www.google.com').size).to eq 1
  end
  
  it "create bookmark with tags" do
    bookmark = create(:bookmark, form_tags: 'tag1, tag2, tag3')
    
    expect(bookmark.tags.size).to eq 3
  end
  
  it "remove bookmark tag" do
    bookmark = create(:bookmark, form_tags: 'tag1, tag2, tag3')
    
    bookmark.form_tags = 'tag1, tag2'
    
    bookmark.save!
    
    expect(bookmark.tags.size).to eq 2
  end
  
  it "add bookmark tag" do
    bookmark = create(:bookmark, form_tags: 'tag1, tag2, tag3')
    
    bookmark.form_tags = 'tag1, tag2, tag3, tag4'
    
    bookmark.save!
    
    expect(bookmark.tags.size).to eq 4
  end
  
  it "checks for valid url" do
    expect(build(:invalid_url_bookmark)).to_not be_valid
  end
end
