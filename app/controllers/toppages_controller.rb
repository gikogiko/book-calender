class ToppagesController < ApplicationController
  before_action :require_user_logged_in, only: [:index]

  def index
    @books = Book.order('updated_at DESC')
    @interestings = current_user.interesting_books
  end
end