class CreateShopperEngineDeliveries < ActiveRecord::Migration
  def change
    create_table :shopper_engine_deliveries do |t|
      t.string  :name
      t.string  :description
      t.integer :price
      t.timestamps
    end
  end
end
