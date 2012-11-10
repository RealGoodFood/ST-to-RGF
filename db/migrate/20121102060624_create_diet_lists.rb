class CreateDietLists < ActiveRecord::Migration
  def self.up
    create_table :diet_lists do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :diet_lists
  end
end
