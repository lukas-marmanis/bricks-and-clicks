class Article < ApplicationRecord

  validates :title, presence: true, length: { maximum: 40 }
  validates :content, :author, :category, :published_at, presence: true

end
