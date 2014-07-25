require 'pp'

class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def create
    pp "******************************************* I am in #{__method__} "
    @article = Article.find(params[:article_id])
    @comment = Comment.new comment_params
    @comment.created_by = current_user.name
    @comment.time = Time.now.utc
    @article.comments << @comment
    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, :notice => 'Comment successfully created.' }
      else
        pp @article.errors.messages
        format.html { redirect_to @article, :alert => @article.errors.full_messages }
      end
    end
  end

  def destroy
    pp "******************************************* I am in #{__method__} "
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @article, :notice => "Comment deleted!" }
    end
  end

  private

  def set_comment
    pp "******************************************* I am in #{__method__} "
    @article = Article.find(params[:article_id])
    @comment = Comment.find(params[:id])
  end

  def comment_params
    pp "******************************************* I am in #{__method__} "
    params.require(:comment).permit(:name, :content)
  end
end

