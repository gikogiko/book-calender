class OwnershipsController < ApplicationController
  def create
    @book = Book.find_or_initialize_by(isbn: params[:book_isbn])

    unless @book.persisted?
      # @book が保存されていない場合、先に @book を保存する
      results = RakutenWebService::Books::Book.search(isbn: @book.isbn)

      @book = Book.new(read(results.first))
      @book.save
    end

    if params[:type] == 'Interesting'
      current_user.interesting(@book)
      flash[:success] = 'この書籍が気になります！'
    elsif params[:type] == 'Order'
      current_user.order(@book)
      flash[:success] = 'この書籍を購入しました！。'
    end

    redirect_back(fallback_location: root_path)
  end

  def destroy
    @book = Book.find(params[:book_id])

    if params[:type] == 'Interesting'
      current_user.uninteresting(@book) 
      flash[:success] = '書籍に興味を示さなくなりました。'
    elsif params[:type] == 'Have'
      current_user.unorder(@book) 
      flash[:success] = '書籍を購入予定から解除しました。'
    end

    redirect_back(fallback_location: root_path)
  end
end