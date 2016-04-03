require 'rails_helper'

RSpec.describe ShopperEngine::Order, type: :model do
  it { is_expected.to belong_to(:credit_card) }
  it { is_expected.to belong_to(:customer) }
  it { is_expected.to have_many(:order_items) }

  it { is_expected.to validate_presence_of(:state) }

  describe '#placed' do
    before do
      @customer = FactoryGirl.create(:customer)
      FactoryGirl.create(:shopper_engine_order, customer: @customer, state: ShopperEngine::Order::PAYMENT)
      FactoryGirl.create(:shopper_engine_order, customer: @customer, state: ShopperEngine::Order::FINISHED)
    end
    it 'must return orders' do
      expect(@customer.orders.placed).to all( be_a(ShopperEngine::Order) )
    end
    it 'must not return not placed orders' do
      expect(@customer.orders.placed).to all( have_attributes(state: ShopperEngine::Order::FINISHED) )
    end
  end


end
