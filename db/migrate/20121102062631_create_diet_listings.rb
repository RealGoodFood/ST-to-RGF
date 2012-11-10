class CreateDietListings < ActiveRecord::Migration
  def self.up
    create_table :diet_listings do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :diet_listings
  end
end
