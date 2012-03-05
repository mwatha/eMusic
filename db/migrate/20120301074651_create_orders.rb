class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table(:orders, :primary_key => 'order_id') do |t|
      t.datetime :start_date 
      t.datetime :end_date 
      t.boolean :canceled, :default => false 
      t.datetime :cancel_date 
      t.datetime :date_created , :default => Time.now()
      t.boolean :retired , :default => false                                                  
      t.interger :retired_by                                                    
      t.datetime :retired_datetime
    end

        ActiveRecord::Base.connection.execute <<EOF                             
ALTER TABLE orders                                                   
ADD COLUMN item_type INT(11) AFTER order_id;                                
EOF

        ActiveRecord::Base.connection.execute <<EOF                             
ALTER TABLE orders                                                   
ADD COLUMN order_status INT(11) AFTER item_type;                                
EOF

        ActiveRecord::Base.connection.execute <<EOF                             
ALTER TABLE orders                                                   
ADD COLUMN orderer INT(11) AFTER order_status;                                
EOF

        ActiveRecord::Base.connection.execute <<EOF                             
ALTER TABLE orders                                                   
ADD COLUMN instruction TEXT AFTER orderer;                                
EOF

  end

  def self.down
    drop_table :orders
  end
end
