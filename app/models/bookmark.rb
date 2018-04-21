require 'uri'
class Bookmark < ApplicationRecord
  belongs_to :site, optional: true
  has_many :taggeds, dependent: :destroy
  has_many :tags, through: :taggeds

  validates :title, :url, presence: true
  validate :validate_url
  validates :unique_id, uniqueness: true
  
  before_save :create_site
  before_validation :generate_unique_id, :on => :create
  
  def validate_url
    begin
      uri = URI.parse(self.url)
      errors.add(:url, 'invalid URL') unless uri && uri.host
    rescue URI::InvalidURIError
      errors.add(:url, 'invalid URL')
    end
  end
  
  def generate_unique_id
    self.unique_id = SecureRandom.urlsafe_base64(5)
    while Bookmark.exists?(unique_id: self.unique_id)
      self.unique_id = SecureRandom.urlsafe_base64(5)
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
    bookmarks = self.includes(:site).left_outer_joins(:tags).where("bookmarks.title LIKE :q OR bookmarks.url LIKE :q OR tags.title LIKE :q", q: "%#{q}%")
    sites = bookmarks.map(&:site).uniq
    results = {}
    sites.each do |site|
      results[site.url.to_s] = bookmarks.where(site: site).uniq
    end
    results
  end
end
