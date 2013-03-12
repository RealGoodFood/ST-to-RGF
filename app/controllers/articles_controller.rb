class ArticlesController < ApplicationController
  layout :choose_layout

  skip_filter :dashboard_only
  skip_filter :not_public_in_private_community, :only => :sign_in

  before_filter :only => [ :edit, :update, :new, :create ] do |controller|
    controller.ensure_logged_in "you_must_log_in_to_view_this_content"
  end

  # GET /swap_items
  # GET /swap_items.xml

  def index
    @articles = Article.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @articles }
    end
  end

  # GET /swap_items/1
  # GET /swap_items/1.xml
  def show
    @article = Article.find(params[:id])
    @article_comments = ArticleComment.where(:article_id => @article.id)  
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml =>  @article }
    end
  end

  # GET /swap_items/new
  # GET /swap_items/new.xml
  def new
    @article = Article.new
  
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /swap_items/1/edit
  def edit
#    @article = Article.find(params[:id])
    @article = current_user.articles.find(params[:id])
  end

  # POST /swap_items
  # POST /swap_items.xml
  def create
    @article = Article.new(params[:article])
    respond_to do |format|
      if @article.save
        format.html { redirect_to(article_path(@article), :notice => 'Article has been added.') }
        format.xml  { render :xml => @article, :status => :created, :location => @article }
#        Delayed::Job.enqueue(SwapOfferJob.new(@swap_item.id, request.host, @current_community.id))
      else
        format.html { redirect_to(new_article_path(@article), :notice => 'Article not added, Please try again') }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /swap_items/1
  # PUT /swap_items/1.xml
  def update
    @article = current_user.articles.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to(article_path(@article), :notice => 'Article has been updated.') }
        format.xml  { head :ok }
      else
        format.html { redirect_to(new_article_path(@article), :notice => 'Article not updated, Please try again') }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /swap_items/1
  # DELETE /swap_items/1.xml
  def destroy
    @article = current_user.articles.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to(articles_path, :notice => 'Article has been deleted.') }
      format.xml  { head :ok }
    end
  end

  private
  
  def choose_layout
    if @current_community && @current_community.private && action_name.eql?("new")
      'private'
    else
      'application'
    end
  end

end
