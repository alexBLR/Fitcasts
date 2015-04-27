class StaticPagesController < ApplicationController
  def home
    @home_page = true
  end

  def help
    @home_page = true
  end

  def contact
    @home_page = true
  end

  def terms
    @home_page = true
  end

  def about
  	@home_page = true
  end

end
