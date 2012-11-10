class CreateSwapItems < ActiveRecord::Migration
  def self.up
    create_table :swap_items do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :swap_items
  end
end
