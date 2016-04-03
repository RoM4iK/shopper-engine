RSpec.describe ShopperEngine::Cart, type: :model do
  describe '#add_item' do
    before do
      @book = FactoryGirl.build(:book)
      @order = FactoryGirl.create(:shopper_engine_cart, order_items_count: 0)
    end
    it 'creates new order_item to this order' do
      expect { @order.add_item(@book) }.to change{ @order.order_items.size }.from(0).to(1)
    end
    it 'change the total price of order' do
      expect { @order.add_item(@book) }.to change{ @order.price }.from(0).to(@book.price)
    end
    describe 'adding more than 1 book quantity' do
      it 'changes order price' do
        expect { @order.add_item(@book, 2) }.to change{ @order.price }.from(0).to(@book.price * 2)
      end
      it 'dont create 2 order items' do
        expect { @order.add_item(@book, 2) }.to change{ @order.order_items.size }.from(0).to(1)
      end
    end
    describe 'adding book that previosly added' do
      before do
        @order.add_item(@book)
      end
      it 'dont change the order size' do
        expect { @order.add_item(@book) }.not_to change{ @order.order_items.size }
      end
      it 'changes order price' do
        expect { @order.add_item(@book) }.to change{ @order.price }.from(@book.price).to(@book.price * 2)
      end
    end
  end
  describe '#update_quantity' do
    before do
      @order = FactoryGirl.create(:shopper_engine_cart, order_items_count: 1)
      @order_item = @order.order_items.first
    end
    context 'with positive quantity' do
      new_quantity = 12
      it 'must change the quantity' do
        expect(@order_item).to receive(:update_quantity).with(new_quantity)
        @order.update_quantity(@order_item, new_quantity)
      end
      it 'must save the order item' do
        expect(@order_item).to receive(:save)
        @order.update_quantity(@order_item, new_quantity)
      end
    end
    context 'with 0 or negative quantity' do
      new_quantity = 0
      it 'must delete the order item' do
        expect(@order_item).to receive(:delete)
        @order.update_quantity(@order_item, new_quantity)
      end
    end
  end
end
