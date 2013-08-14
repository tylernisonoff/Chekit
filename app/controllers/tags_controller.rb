class TagsController < ApplicationController
  def create
    puts params.inspect
    @tag = Tag.new(params[:tag])
    if @tag.save
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    respond_to do |format|
      format.js 
    end
  end
end
