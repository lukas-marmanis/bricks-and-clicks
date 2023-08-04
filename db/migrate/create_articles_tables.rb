class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    # Create a new table named 'articles'
    create_table :articles do |t|
      # Define columns and their data types for the 'articles' table
      t.string :title        # Title of the article (maximum length: 255 characters)
      t.text :content        # Content of the article (long text)
      t.string :author       # Author of the article (maximum length: 255 characters)
      t.string :category     # Category of the article (maximum length: 255 characters)
      t.datetime :published_at   # Published date and time of the article

      # Automatic timestamps columns for created_at and updated_at
      t.timestamps
    end
  end
end
