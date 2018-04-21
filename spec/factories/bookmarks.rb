FactoryBot.define do
  factory :bookmark do
    title "Google Map"
    url "https://www.google.com/maps?source=tldsi&hl=en"
  end
  
  factory :site do
    url "https://www.google.com"
  end
  
  factory :edited_bookmark, class: Bookmark do
    title "Edited Title"
    url "https://google.com/edited"
    form_tags "edited_tag"
  end
  
  factory :bookmark_with_title_only, class: Bookmark do
    title "URL Title"
    url nil
  end
  
  factory :invalid_url_bookmark, class: Bookmark do
    title "URL Title"
    url "http://testing invalid-url.com"
  end
end