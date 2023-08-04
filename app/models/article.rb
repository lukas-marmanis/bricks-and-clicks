class Article < ApplicationRecord
  # Model validations
  validates :title, presence: true, length: { maximum: 40 }
  validates :content, :author, :category, :published_at, presence: true

  # Custom as_json method to format the JSON response
  def as_json(options = {})
    # Call the original as_json method of ApplicationRecord to generate the initial JSON hash
    super(except: [:created_at, :updated_at]).tap do |hash|
      # Format the published_at attribute to display only the date in 'YYYY-MM-DD' format
      hash['published_at'] = published_at.strftime('%Y-%m-%d')
    end
  end
end


