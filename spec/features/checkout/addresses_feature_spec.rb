require 'rails_helper'
require 'support/checkout_context'

feature "Checkout addresses" do
  include_context 'checkout_context'
  context "User have no saved addresses" do
    before do
      visit shopper_engine.checkout_path(id: :billing)
    end
    scenario "Should not render address select form" do
      expect(page).to_not have_selector('form.edit_cart')
    end
  end
  context "User have saved addresses" do
    before do
      @address = FactoryGirl.create(:shopper_engine_address, customer: @customer)
      visit shopper_engine.checkout_path(id: :billing)
    end
    scenario "Should render address select form" do
      expect(page).to have_selector('form.edit_cart')
    end
    describe "User can select saved address" do
      before do
        within 'form.edit_cart' do
          select(@address.address, from: 'cart_billing_address')
          click_button('Select')
        end
      end
      scenario "Should redirect to shipping address" do
        expect(current_path).to eq(shopper_engine.checkout_path(id: :shipping))
      end
      scenario "Should change the selected address in address form" do
        visit shopper_engine.checkout_path(id: :billing)
        expect(page).to have_selector('form.edit_cart option[selected="selected"]', text: @address.address)
      end
    end
  end
  describe "User can skip shipping address" do
    before do
      @address = FactoryGirl.create(:shopper_engine_address, customer: @customer)
      visit shopper_engine.checkout_path(id: :billing)
      within 'form.edit_cart' do
        select(@address.address, from: 'cart_billing_address')
        click_button('Select')
      end
    end
    scenario "Should have skip button" do
      expect(page).to have_selector('.skip-shipping')
    end
    scenario "Should change the selected address in address form" do
      within '.skip-shipping' do
        click_button('Use billing address')
      end
      visit shopper_engine.checkout_path(id: :shipping)
      expect(page).to have_selector('form.edit_cart option[selected="selected"]', text: @address.address)
    end
  end
end
