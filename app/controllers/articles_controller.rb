class ArticlesController < ApplicationController
  # GET /articles
  def index
    # Fetch articles from the database, ordered by published_at in descending order
    articles = Article.order(published_at: :desc)

    # Render the articles as JSON response
    render json: articles
  end

  # POST /articles
  def create
    # Extract article parameters from the request
    article_params = params.permit(:title, :content, :author, :category, :published_at)

    # Check if article_params are empty
    if article_params.blank?
      render json: { message: 'Article not found' }, status: :not_found
      return
    end

    # Attempt to create a new article with the provided parameters
    begin
      article = Article.create!(
        title: article_params[:title],
        content: article_params[:content],
        author: article_params[:author],
        category: article_params[:category],
        published_at: article_params[:published_at]
      )

      # If the article is successfully created, render it as JSON response with status code 201 (created)
      render json: article, status: :created
    rescue ActiveRecord::RecordInvalid => e
      # If the article creation fails due to validation errors, render the error message with status code 422 (unprocessable_entity)
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end

  # GET /articles/:id
  def show
    # Find the article by the provided id
    article = Article.find_by(id: params[:id])

    # Check if the article is found
    if article
      # Render the article as JSON response
      render json: article
    else
      # If the article is not found, render a JSON response with status code 404 (not_found)
      render json: { message: 'Article not found' }, status: :not_found
    end
  end

  # Handling DELETE, PUT, and PATCH requests for /articles/:id
  def destroy
    # Respond with status code 405 (method_not_allowed) for delete requests
    head :method_not_allowed
  end

  def update
    # Respond with status code 405 (method_not_allowed) for update requests
    head :method_not_allowed
  end

  def patch
    # Respond with status code 405 (method_not_allowed) for patch requests
    head :method_not_allowed
  end

  private

  # Method to permit and extract article parameters from the request
  def article_params
    params.permit(:title, :content, :author, :category, :published_at)
  end
end
