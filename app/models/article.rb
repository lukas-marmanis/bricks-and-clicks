class Article < ApplicationRecord
  validates :title, presence: true, length: { maximum: 40 }
  validates :content, :author, :category, :published_at, presence: true

  def as_json(options = {})
    super(except: [:created_at, :updated_at]).tap do |hash|
      hash['published_at'] = published_at.strftime('%Y-%m-%d')
    end
  end
end

