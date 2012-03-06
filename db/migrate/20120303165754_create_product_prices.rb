class CreateProductPrices < ActiveRecord::Migration
  def self.up
    create_table(:product_prices, :primary_key => 'product_price_id') do |t|
      t.datetime :date_created ,:default => Time.now()
      t.boolean :retired ,:default => false                                                  
      t.interger :voided_by                                                    
      t.datetime :retired_datetime                                              
      t.string :retired_reason                                                    
    end

        ActiveRecord::Base.connection.execute <<EOF                                 
ALTER TABLE product_prices                                                        
ADD COLUMN product_unique_id INT(11) AFTER product_price_id;                                
EOF
                                                                                
        ActiveRecord::Base.connection.execute <<EOF                                 
ALTER TABLE product_prices                                                        
ADD COLUMN product_category INT(11) AFTER product_unique_id;                                
EOF

        ActiveRecord::Base.connection.execute <<EOF                                 
ALTER TABLE product_prices                                                        
ADD COLUMN price DOUBLE AFTER product_category;                                
EOF

        ActiveRecord::Base.connection.execute <<EOF                                 
ALTER TABLE product_prices                                                        
ADD COLUMN quantity DOUBLE AFTER price;                                
EOF

  end

  def self.down
    drop_table :product_prices
  end
end
