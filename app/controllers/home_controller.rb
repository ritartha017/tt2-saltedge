class HomeController < ApplicationController
  def index
    if current_user.present? 
      render 'index'
    else
      render 'create'
    end
  end

  def show
  end
end
