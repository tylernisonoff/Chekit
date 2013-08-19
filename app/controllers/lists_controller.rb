class ListsController < ApplicationController
  before_filter :auth_user!

  def full
    @lists = current_user.lists
  end

  def index
    @lists = current_user.lists
    #terrible hard-code for testing reasons
    @sorted_tags = []
  end

  def show
    list = List.find(params[:id])
    @sorted_tags = list.sorted_tags
    @items = list.items
    respond_to do |format|
      format.js
    end
  end

  def filter
    tag = params[:tag]
    list = List.find(params[:id])
    if tag.present?
      @items = list.items_with_tag tag
      puts @items.inspect
    else
      @items = list.items
    end
  end

  def new
    @list = List.new
  end

  def create
    @list = current_user.lists.new(params[:list])
    if @list.save
      respond_to do |format|
        format.js 
      end
    end
  end

  def destroy
    @id = params[:id]
    List.find(@id).destroy
    respond_to do |format|
      format.js 
    end
  end

  def auth_user!
    redirect_to new_user_registration_url unless user_signed_in?
  end
end
