class ItemTag < ActiveRecord::Base
  belongs_to :tag
  belongs_to :item
  attr_accessible :item_id, :tag_id
end
