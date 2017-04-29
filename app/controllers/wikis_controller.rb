class WikisController < ApplicationController

  def index
    @wikis = Wiki.all
  end

  def new
  end

  def create
  end

  def show
    @name = Name.find_by(name: params[:name])
    if @name
      @wiki = @name.wiki
      @page = @wiki.page
      render :wiki
    else
      render :new_wiki
    end
  end
end



