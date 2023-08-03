class ArticlesController < ApplicationController
    def index
      articles = Article.order(published_at: :desc)
      render json: articles
    end

    def create
      article_params = params.permit(:title, :content, :author, :category, :published_at)

      if article_params.blank?
        render json: { message: 'Article not found' }, status: :not_found
        return
      end

      begin
        article = Article.create!(
          title: article_params[:title],
          content: article_params[:content],
          author: article_params[:author],
          category: article_params[:category],
          published_at: article_params[:published_at]
        )
        render json: article, status: :created
      rescue ActiveRecord::RecordInvalid => e
        render json: { error: e.message }, status: :unprocessable_entity
      end
    end




      private
      def article_params
        params.require(:article).permit(:title, :content, :author, :category, :published_at)
      end

    def show
      article = Article.find_by(id: params[:id])
      if article
        render json: article
      else
        render json: { message: 'Article not found' }, status: :not_found
      end
    end

    # Handling DELETE, PUT, and PATCH requests for /articles/:id
    def destroy
      head :method_not_allowed
    end

    def update
      head :method_not_allowed
    end

    def patch
      head :method_not_allowed
    end
  end
