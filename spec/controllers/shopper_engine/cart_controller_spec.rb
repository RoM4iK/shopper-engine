require 'rails_helper'

module ShopperEngine
  RSpec.describe CartController, type: :controller do
    routes { ShopperEngine::Engine.routes }

    describe '#add' do
      before do
        @book = FactoryGirl.create(:book)
        @quantity = 10
      end
      it 'must find book' do
        expect(Book).to receive(:find).with(@book.id.to_s).and_call_original
        post :add, product_type: @book.product_type, product_id: @book, quantity: @quantity
      end
      it 'must add it to order' do
        expect_any_instance_of(Cart).to receive(:add_item).with(@book, @quantity.to_s)
        post :add, product_type: @book.product_type, product_id: @book, quantity: @quantity
      end
      it 'must set flash notice' do
        post :add, product_type: @book.product_type, product_id: @book, quantity: @quantity
        expect(controller).to set_flash
      end
      it 'must redirect to root' do
        post :add, product_type: @book.product_type, product_id: @book, quantity: @quantity
        expect(controller).to redirect_to action: :index
      end
    end

    describe '#update_quantity', :not_verify_doubles do
      before do
        @book = FactoryGirl.create(:book)
        @cart = FactoryGirl.create(:shopper_engine_cart)
        @quantity = 10
        @cart.add_item(@book)
        @order_item = @cart.order_items.first
        allow_any_instance_of(ShopperEngine::CartController).to receive(:get_cart) { @cart }
      end
      it 'must update quantity of order item' do
        expect(@cart).to receive(:update_quantity).with(@order_item, @quantity.to_s)
        post :update_quantity, id: @order_item.id, quantity: @quantity
      end
      it 'must redirect to index' do
        post :update_quantity, id: @order_item.id, quantity: @quantity
        expect(controller).to redirect_to action: :index
      end
    end
  end
end
