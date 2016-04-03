class CreateShopperEngineOrderItems < ActiveRecord::Migration
  def change
    create_table :shopper_engine_order_items do |t|
      t.integer  :price
      t.integer  :quantity
      t.references :product, polymorphic: true
      t.belongs_to :order
      t.datetime :placed_at
      t.timestamps null: false
    end
  end
end
