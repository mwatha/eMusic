class CreateProductPriceCategories < ActiveRecord::Migration
  def self.up
    create_table(:product_price_category, :primary_key => 'product_price_category_id') do |t|
      t.string :name                                                            
      t.interger :creator                                                       
      t.datetime :date_created ,:default => Time.now()
      t.boolean :retired ,:default => false                                                  
      t.interger :voided_by                                                    
      t.datetime :retired_datetime                                              
      t.string :retired_reason                                                    
    end 
  end

  def self.down
    drop_table :product_price_category
  end
end
