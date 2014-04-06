# encoding: utf-8
class ButtonsController < ApplicationController
  layout 'application'
  respond_to :html
  respond_to :js, only: [:index]
  before_filter :find_button, only: [:show, :edit, :update, :destroy]

  def index
    respond_with collection
  end
  
  def create
    @button = current_team.buttons.build(buttons_params.merge(user: current_user))
    @button.save 
    respond_with @button
  end
  
  def update
    @button.update_attributes(buttons_params)
    respond_with @button
  end

  def collection
    @buttons = current_team.buttons.page(params[:page] || 1)
  end

  def upload 
    if request.post? and params[:bookmark]
      @results = BookmarkParser.parseFile(params[:bookmark].tempfile.path)      
      flash[:notice] = "File processed: #{@results.length} bookmarks detected."
    end
  end

  def destroy
    @button.destroy
    redirect_to buttons_url
  end

  def import
    urls = params[:urls]
    titles = params[:titles]
    sel = params[:selection]

    sel.each { |ind| Button.create({url: urls[ind.to_i], title: titles[ind.to_i], author: current_user}) }
  end

  private 
  def buttons_params
    params.require(:button).permit(:url, :title, :description)
  end

  def find_button
    @button = current_team.buttons.find params[:id]
  end
end

