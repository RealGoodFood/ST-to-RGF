class CreateFormDetails < ActiveRecord::Migration
  def self.up
    create_table :form_details do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :form_details
  end
end
