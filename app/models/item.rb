class Item < ActiveRecord::Base
  belongs_to :list, dependent: :destroy

  attr_accessible :name, :list_id
end
