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
    puts "here"
    @list = List.find(params[:id])
    @sorted_tags = @list.sorted_tags
    respond_to do |format|
      format.js
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
    @list = List.find(params[:id])
    @list.destroy
  end
end
