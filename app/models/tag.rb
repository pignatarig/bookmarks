class Tag < ApplicationRecord
  has_many :taggeds
  has_many :bookmarks, through: :taggeds
end
