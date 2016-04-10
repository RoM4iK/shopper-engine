require 'rails_helper'
module ShopperEngine
  RSpec.describe CartHelper, :not_verify_doubles, type: :helper do
    before do
      @helper = Object.new.extend CartHelper
      @product = FactoryGirl.build(:book)
      allow(@helper).to receive(:render)
    end
    describe '#add_to_cart_button' do
      it 'must create instance variable with product' do
        expect{@helper.add_to_cart_button(@product)}.to change{@helper.instance_variable_get(:@product)}.from(nil).to(@product)
      end
      it 'must render partial with button' do
        expect(@helper).to receive(:render).with(partial: 'shopper_engine/cart/add_to_cart_button')
        @helper.add_to_cart_button(@product)
      end
    end
  end
end
