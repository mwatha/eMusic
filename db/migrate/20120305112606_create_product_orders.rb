class CreateProductOrders < ActiveRecord::Migration
  def self.up
    create_table(:product_order, :primary_key => 'product_order_id') do |t|
    end

        ActiveRecord::Base.connection.execute <<EOF                             
ALTER TABLE product_order                                                  
ADD COLUMN order_id INT(11) AFTER product_order_id;                                
EOF

        ActiveRecord::Base.connection.execute <<EOF                             
ALTER TABLE product_order                                                  
ADD COLUMN price DOUBLE AFTER order_id;                                
EOF

        ActiveRecord::Base.connection.execute <<EOF                             
ALTER TABLE product_order                                                  
ADD COLUMN quantity INT(11) AFTER price;                                
EOF

        ActiveRecord::Base.connection.execute <<EOF                             
ALTER TABLE product_order                                                  
ADD COLUMN total_cost DOUBLE AFTER quantity;                                
EOF

  end

  def self.down
    drop_table :product_order
  end
end
