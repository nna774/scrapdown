class WikisController < ApplicationController

  def index
    @wikis = Wiki.all.order(updated_at: :desc)
  end

  def new
    @name = Name.new(name: params[:name])
    @page = Page.new(content: params[:content])
  end

  def create
    pagename = wiki_params[:name][:name]
    content = wiki_params[:page][:content]
    if pagename.blank?
      # 適切なメッセージを出す方が良い(ブラウザのvalidation通ってるハズなので要らない？)。
      render :new
      return
    end

    @name = Name.find_by(name: pagename)
    if @name # 既に同名のページが存在
      # 名前がかぶっているというメッセージを出す。
      redirect_to action: :new, name: pagename, content: content, status: 302
      return
    end

    @wiki = Wiki.create
    @name = Name.create(name: pagename, wiki_id: @wiki.id)
    @page = Page.create(content: content, wiki_id: @wiki.id)

    redirect_to action: :show, name: pagename, status: 302
  end

  def show
    @name = Name.find_by(name: params[:name])
    if @name
      @wiki = @name.wiki
      @page = @wiki.page
      render :wiki
    else
      @name = Name.new(name: params[:name])
      @page = Page.new(content: params[:content])
      render :new
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(name: [:name], page: [:content])
  end
end
