class CreateShopperEngineAddresses < ActiveRecord::Migration
  def change
    create_table :shopper_engine_addresses do |t|
      t.string :phone
      t.string :address
      t.string :zipcode
      t.string :city
      t.belongs_to :country
      t.belongs_to :customer
      t.timestamps null: false
    end
  end
end
