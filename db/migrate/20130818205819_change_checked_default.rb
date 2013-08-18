class ChangeCheckedDefault < ActiveRecord::Migration
  def up
    change_column :items, :checked, :boolean, default: false
  end

  def down
    change_column :items, :checked
  end
end
