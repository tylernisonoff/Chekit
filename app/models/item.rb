class Item < ActiveRecord::Base
  belongs_to :list
  has_many :item_tags, dependent: :destroy
  has_many :tags, through: :item_tags

  attr_accessible :name, :list_id, :checked
end
