require 'rails_helper'

module ShopperEngine
  RSpec.describe CheckoutController, type: :controller do
    routes { ShopperEngine::Engine.routes }
    let :new_user_session_path do
      controller.main_app.send("new_#{ShopperEngine.devise_scope}_session_path")
    end
    let :first_step_id do
      :billing
    end
    describe '#index' do
      context "When user is logged" do
        before do
          @user = FactoryGirl.create(:customer)
          sign_in @user
        end
        it 'must redirect to show action with first step id' do
          get :index
          expect(controller).to redirect_to action: :show, id: first_step_id
        end
      end
      context "When user not logged" do
        it 'must redirect to sign in page' do
          get :index
          expect(controller).to redirect_to new_user_session_path
        end
      end
    end
    describe '#show' do
      context "When user is logged" do
        before do
          @user = FactoryGirl.create(:customer)
          sign_in @user
        end
        context "When user has no items in cart" do
          it 'must redirect to cart' do
            get :show, id: first_step_id
            expect(controller).to redirect_to cart_path
          end
        end
      end
      context "When user not logged" do
        it 'must redirect to sign in page' do
          get :show, id: first_step_id
          expect(controller).to redirect_to new_user_session_path
        end
      end
    end
  end
end
