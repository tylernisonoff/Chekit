class ListsController < ApplicationController
  def full
    @lists = List.all
  end

  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
    respond_to do |format|
      format.json { render json: @list.items }
    end
  end

  def new
    @list = List.new
  end

  def create
    @list = params[:list]
    redirect_to @list
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy

    redirect_to lists_path
  end
end
