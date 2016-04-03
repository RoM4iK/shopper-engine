class CreateShopperEngineOrderItems < ActiveRecord::Migration
  def change
    create_table :shopper_engine_order_items do |t|
      t.integer  :price
      t.integer  :quantity
      t.references :product, polymorphic: true
      t.belongs_to :book
      t.belongs_to :order
      t.timestamps
    end
  end
end
