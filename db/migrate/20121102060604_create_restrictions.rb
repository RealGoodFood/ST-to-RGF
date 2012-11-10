class CreateRestrictions < ActiveRecord::Migration
  def self.up
    create_table :restrictions do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :restrictions
  end
end
