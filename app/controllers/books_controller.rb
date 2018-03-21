class BooksController < ApplicationController
  before_action :require_user_logged_in

  def show
    @book = Book.find(params[:id])
    @interesting_users = @book.interesting_users
    @order_users = @book.order_users    
  end

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

  # https://webservice.rakuten.co.jp/api/booksbooksearch/
  def reload
    book = Book.find(params[:id])
    
    publish_date = 'xxx' # ここを API から取得する
    book.publish_date = publish_date

    book.save
  end
end