class AddListIdToTags < ActiveRecord::Migration
  def change
    add_column :tags, :list_id, :integer
  end
end
