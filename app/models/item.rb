class Item < ActiveRecord::Base
  belongs_to :list, dependent: :destroy
  has_many :item_tags
  has_many :tags, through: :item_tags

  attr_accessible :name, :list_id
end
