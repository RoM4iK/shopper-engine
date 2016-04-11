require 'rails_helper'
require 'support/checkout_context'

feature "Checkout" do
  feature "User can open checkout page" do
    context "User has logged in" do
      include_context 'checkout_context'
      scenario "Should redirect to fisrt checkout step" do
        expect(current_path).to eq(shopper_engine.checkout_path id: 'billing')
      end
    end
    context "User has not logged in" do
      before do
        @book = FactoryGirl.create(:book)
        visit root_path
        within('.add-to-cart-button') do
          click_button 'Add to cart'
        end
        visit shopper_engine.cart_path
        click_link 'Checkout'
      end
      scenario "Should redirect to login page" do
        expect(current_path).to eq(new_customer_session_path)
      end
    end
  end
  feature "User can fill checkout forms" do
    include_context 'checkout_context'
    before do
      FactoryGirl.create(:shopper_engine_country)
    end
    context "With correct data" do
      before do
        @first_path = shopper_engine.checkout_path(id: :billing)
        @address = FactoryGirl.build(:shopper_engine_address)
        visit @first_path
        within '#new_address' do
          fill_in 'Address', with: @address.address
          fill_in 'Zipcode', with: @address.zipcode
          fill_in 'City', with: @address.city
          fill_in 'Phone', with: @address.phone
          click_button 'Save'
        end
      end
      scenario "should redirect to next step" do
        expect(current_path).to_not eq(@first_path)
      end
    end
    context "With incorrect data" do
      before do
        @first_path = shopper_engine.checkout_path(id: :billing)
        visit @first_path
        within '#new_address' do
          click_button 'Save'
        end
      end
      scenario "should not redirect to not step" do
        expect(current_path).to eq(@first_path)
      end
      scenario "should display validation errors" do
        expect(page).to have_selector('.alert-danger')
      end
    end
  end
  feature "User open confirmation page" do
    include_context "checkout_context"
    context "When user fill all forms" do
      before do
        FactoryGirl.create(:shopper_engine_country)
        @address = FactoryGirl.build(:shopper_engine_address)
        @delivery = FactoryGirl.create(:shopper_engine_delivery)
        @credit_card = FactoryGirl.build(:shopper_engine_credit_card, customer: @customer)
        visit shopper_engine.checkout_index_path
        within '#new_address' do
          fill_in 'Address', with: @address.address
          fill_in 'Zipcode', with: @address.zipcode
          fill_in 'City', with: @address.city
          fill_in 'Phone', with: @address.phone
          click_button 'Save'
        end
        expect(current_path).to eq(shopper_engine.checkout_path id: :shipping)
        within '.skip-shipping' do
          click_button('Use billing address')
        end
        expect(current_path).to eq(shopper_engine.checkout_path id: :delivery)
        within('.edit_cart') do
          choose(@delivery.name)
          click_button('Save')
        end
        expect(current_path).to eq(shopper_engine.checkout_path id: :payment)
        within '#new_credit_card' do
          fill_in 'Number', with: @credit_card.number
          fill_in 'Cvv', with: @credit_card.cvv
          fill_in 'Expiration month', with: @credit_card.expiration_month
          fill_in 'Expiration year', with: @credit_card.expiration_year
          fill_in 'First name', with: @credit_card.first_name
          fill_in 'Last name', with: @credit_card.last_name
          click_button 'Save'
        end
      end
      scenario 'should redirect to confirmation page' do
        expect(current_path).to eq(shopper_engine.checkout_path id: :confirmation)
      end
      scenario 'should have address info' do
        expect(page).to have_content(@address.address)
      end
      scenario 'should have delivery info' do
        expect(page).to have_content(@delivery.name)
      end
      scenario 'should have credit card info' do
        expect(page).to have_content(@credit_card.number)
      end
    end
    context "When user don't fill all forms" do
      before do
        visit shopper_engine.checkout_path id: :confirmation
      end
      scenario 'should redirect to first step' do
        expect(current_path).to eq(shopper_engine.checkout_path id: :billing)
      end
      scenario 'should display error' do
        expect(page).to have_selector('.alert-danger')
      end
    end
  end
end
