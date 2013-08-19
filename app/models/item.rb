class Item < ActiveRecord::Base
  has_many :item_tags, dependent: :destroy
  has_many :tags, through: :item_tags
  belongs_to :list
  attr_accessible :name, :list_id, :checked
end
