class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def read(result)
    isbn = result['isbn']
    name = result['title']
    author = result['author']
    value = result['itemPrice']
    url = result['itemUrl']
    image_url = result['largeImageUrl']
    release_date = result['salesDate']
    
  return {
    isbn: isbn,
    name: name,
    author: author,
    value: value,
    url: url,
    image_url: image_url,
    release_date: release_date,
    }
  end
end