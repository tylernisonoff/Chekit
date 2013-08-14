class ItemsController < ApplicationController
  def create
    puts params.inspect
    @item = Item.new(params[:item])
    if @item.save
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    @item = Item.find(params[:id])
    respond_to do |format|
      format.js 
    end
  end

  def tag
    @tag = Tag.where(name: params[:name]).first_or_create
    @item_tag = ItemTag.new(item_id: params[:item_id], tag_id: @tag.id)
    if @item_tag.save
      respond_to do |format|
        format.js
      end
    end
  end
end
