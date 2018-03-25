require 'uri'
class Bookmark < ApplicationRecord
  belongs_to :site, optional: true
  has_many :taggeds, dependent: :destroy
  has_many :tags, through: :taggeds

  validates :title, :url, presence: true
  validate :validate_url
  
  before_save :create_site
  
  def validate_url
    begin
      uri = URI.parse(self.url)
      errors.add(:url, 'invalid URL') unless uri && uri.host
    rescue URI::InvalidURIError
      errors.add(:url, 'invalid URL')
    end
  end
  
  def create_site
    if self.url
      url = URI.parse(self.url)
      if Site.where(url: url.scheme.to_s + '://' + url.host.to_s).count == 0
        self.site = Site.create(url: url.scheme.to_s + '://' + url.host.to_s)
      else
        self.site = Site.where(url: url.scheme.to_s + '://' + url.host.to_s).first
      end
    end
  end
  
  def form_tags
    self.tags.map(&:title).join(', ')
  end
  
  def form_tags=(tag_texts)
    self.tags = tag_texts.split(',').map do |n|
      Tag.where(title: n.strip).first_or_create!
    end
  end
  
  def self.search(q)
    self.left_outer_joins(:tags).where("bookmarks.title LIKE :q OR bookmarks.url LIKE :q OR tags.title LIKE :q", q: "%#{q}%").uniq
  end
end
