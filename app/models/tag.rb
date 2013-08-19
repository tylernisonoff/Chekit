class Tag < ActiveRecord::Base
  has_many :item_tags, dependent: :destroy
  has_many :items, through: :item_tags
  belongs_to :list

  attr_accessible :name, :list_id
end
