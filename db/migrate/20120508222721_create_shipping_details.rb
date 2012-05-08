class CreateShippingDetails < ActiveRecord::Migration
  def self.up
    create_table :shipping_details do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :shipping_details
  end
end
