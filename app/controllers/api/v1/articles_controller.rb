class Api::V1::ArticlesController < ApplicationController
  respond_to :json

  def index
    respond_with :api, :v1, Article.all
  end

  def show
    respond_with Article.find_by!(id: params[:id])
  end

  def create
    @artist = Article.new(article_params)
    if @artist.save
      respond_with :api, :v1, @artist
    else
      respond_with @artist.errors.full_messages.join(", ")
    end
  end

  def destroy
    render json: Article.destroy(params[:id]), status: 200, location: nil
  end

  def update
    @artist = Article.find_by!(id: params[:id])
    if @artist.update_attributes(article_params)
      render json: @artist, status: 200, location: [:api, :v1, @artist]
    else
      artist_errors = @artist.errors.full_messages.join(", ")
      render json: artist_errors, location: [:api, :v1, artist_errors]
    end
  end

  private

  def article_params
    params.permit(:body, :title, :article_id)
  end
end
