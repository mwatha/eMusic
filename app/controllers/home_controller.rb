class HomeController < ApplicationController
  def index
  end

  def cancel_order
    session[:cart] = nil
    redirect_to('/')
  end

end
