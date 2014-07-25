require 'pp'

class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :analysis]

  def index
    pp "******************************************* I am in #{__method__} "
    @articles = Article.all
  end

  def create
    pp "******************************************* I am in #{__method__} "
    @article = Article.new(article_params)
    @article.created_by = current_user.name
    @article.time = Time.now
      respond_to do |format|
      if @article.save
        format.html { redirect_to article_path(@article), :notice => 'Article was successfully created.' }
      else
        format.html { render action: 'new', :alert => "Article not created !!" }
      end
    end
  end

  def new
    pp "******************************************* I am in #{__method__} "
    @article = Article.new
  end

  def edit
    pp "******************************************* I am in #{__method__} "
  end

  def show
    pp "******************************************* I am in #{__method__} "
    hashData = @article.get_analysis_data(Time.now,250000,15);
  end

  def update
    pp "******************************************* I am in #{__method__} "
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    pp "******************************************* I am in #{__method__} "

    respond_to do |format|
      if @article.destroy
        format.html { redirect_to @article, notice: 'Article was successfully deleted.' }
      else
        format.html { render action: 'show' }
      end
    end
  end

  def analysis
    hashData = @article.get_analysis_data(Time.now,250000,15);
    pp "*******************DDDDDD In Article Controller DDDD************************* #{hashData}"
    render json: hashData;
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    pp "******************************************* I am in #{__method__} "
    @article = Article.find(params[:id])
  end

  def article_params
    pp "******************************************* I am in #{__method__} "
    params.require(:article).permit(:name, :content)
  end

end