class BooksController < ApplicationController
  before_action :require_user_logged_in

  def new
    @books = []

    @title = params[:title]
    if @title.present? # 
      results = RakutenWebService::Books::Book.search({
        title: @title,
        hits: 20,
      })

      results.each do |result|
        book = Book.find_or_initialize_by(read(result))
        @books << book
      end
    end
  end

  private

  def read(result)
    isbn = result['isbn']
    name = result['title']
    author = result['author']
    value = result['itemPrice']
    url = result['itemUrl']
    image_url = result['largeImageUrl']
    
    return {
      isbn: isbn,
      name: name,
      author: author,
      value: value,
      url: url,
      image_url: image_url,
    }
  end
end