class ListsController < ApplicationController
  def full
    @lists = List.all
  end

  def index
    @lists = List.all
    #terrible hard-code for testing reasons
    @sorted_tags = List.first.sorted_tags
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
    @list = List.new(params[:list])
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
end
