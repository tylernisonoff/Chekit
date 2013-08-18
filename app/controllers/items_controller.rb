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

  def update
    Item.find(params[:id]).update_attributes!(update_params)
    render nothing: true
  end

  def destroy
    @id = params[:id]
    item = Item.find(@id)
    list = item.list
    item.destroy
    @sorted_tags = list.sorted_tags
    respond_to do |format|
      format.js 
    end
  end

  def tag
    @tag = Tag.where(name: params[:name], list_id: params[:list_id]).first_or_create
    @item_tag = ItemTag.new(item_id: params[:item_id], tag_id: @tag.id)
    
    
    if @item_tag.save
      list = List.find(@tag.list_id)
      @sorted_tags = list.sorted_tags
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy_tag
    @item_id = params[:item_id]
    @name = params[:name]
    list = List.find(params[:list_id])
    tag = Tag.where(name: @name, list_id: list.id).first

    ItemTag.where(item_id: @item_id, tag_id: tag.id).destroy_all

    tags_hash  = list.tags
    @sorted_tags = list.sorted_tags
    count = tags_hash[tag.name]
    Tag.find(tag.id).destroy if count == 0
  end

  private
    def update_params
      params[:item].slice(:checked)
    end
end
