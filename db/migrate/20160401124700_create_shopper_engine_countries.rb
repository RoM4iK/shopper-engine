class CreateShopperEngineCountries < ActiveRecord::Migration
  def change
    create_table :shopper_engine_countries do |t|
      t.string   :name
      t.belongs_to :address
      t.timestamps
    end
  end
end
