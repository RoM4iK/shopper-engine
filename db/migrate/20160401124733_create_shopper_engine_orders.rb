class CreateShopperEngineOrders < ActiveRecord::Migration
  def change
    create_table :shopper_engine_orders do |t|
      t.integer  :price, default: 0
      t.date     :completed_date
      t.integer  :state
      t.integer  :shipping_address_id
      t.integer  :billing_address_id
      t.belongs_to :customer
      t.belongs_to :credit_card
      t.belongs_to :delivery
      t.datetime :placed_at
      t.timestamps null: false
    end
  end
end
