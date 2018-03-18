class OwnershipsController < ApplicationController
  def create
    @book = Book.find_or_initialize_by(isbn: params[:book_isbn])

    unless @book.persisted?
      # @book が保存されていない場合、先に @book を保存する
      results = RakutenWebService::Books::Book.search(isbn: @book.isbn)

      @book = Book.new(read(results.first))
      @book.save
    end

    # Interesting 関係として保存
    if params[:type] == 'Interesting'
      current_user.interesting(@book)
      flash[:success] = 'この書籍が気になります！'
    end

    redirect_back(fallback_location: root_path)
  end

  def destroy
    @book = Book.find(params[:book_id])

    if params[:type] == 'Interesting'
      current_user.uninteresting(@book) 
      flash[:success] = '商品の Interesting を解除しました。'
    end

    redirect_back(fallback_location: root_path)
  end
end