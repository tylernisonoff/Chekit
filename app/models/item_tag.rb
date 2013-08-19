class ItemTag < ActiveRecord::Base
  belongs_to :tag
  belongs_to :item
  attr_accessible :item_id, :tag_id

  validates_uniqueness_of :item_id, :scope => :tag_id
end
