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

    # つながっているnameの抽出等をここでする。

    redirect_to action: :show, name: pagename, status: 302
  end

  def show
    @name = Name.find_by(name: params[:name])
    if @name
      # そのタイトルのページ発見。
      @wiki = @name.wiki
      if @wiki.nil?
        # 変更前のページタイトルなのでリダイレクトする。
        render text: CGI.escapeHTML(@name.inspect)
        return
      end
      @page = @wiki.page
      render :wiki
    else
      # なかったので新規画面を出しとく。
      @name = Name.new(name: params[:name])
      @page = Page.new(content: params[:content])
      render :new
    end
  end

  def edit
    @name = Name.find_by(name: params[:name])
    @wiki = @name.wiki
    @page = @wiki.page
    render :edit
  end

  def update
    @name = Name.find(params.dig(:wiki, :name, :id))
    @wiki = @name.wiki
    if @wiki.nil?
      # 
    end
    @page = @wiki.page

    if params.dig(:wiki, :page, :id).to_i != @page.id
      puts "here!!"
      binding.pry
      # コンフリクト発生
    end

    if (newname = params.dig(:wiki, :name, :name)) != @name.name && !newname.nil?
      # ページタイトル変更発生！
      oldname = @name.name
      @name.name = newname
      @name.save
      @name.reload
      Name.create!(name: oldname, changed_to: @name.id) # 古い名前のリダイレクト用エントリの作成
      @wiki.touch
      @wiki.save
    end

    newcontent = params.dig(:wiki, :page, :content)
    if newcontent == @page.content
      # 変更無し
      redirect_to action: :show, name: @name.name, status: 302
      return
    end

    newpage = Page.create(wiki_id: @wiki.id, content: newcontent)
    @wiki.page = newpage
    @wiki.save
    redirect_to action: :show, name: @name.name, status: 302
  end

  private

  def wiki_params
    params.require(:wiki).permit(name: [:name], page: [:content])
  end
end
