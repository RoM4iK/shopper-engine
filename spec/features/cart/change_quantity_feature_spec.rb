require 'rails_helper'

feature "Change quantity" do
  before do
    @book = FactoryGirl.create(:book)
    visit root_path
    within('.add-to-cart-button') do
      click_button 'Add to cart'
    end
  end
  feature "User changes quantity to positive value" do
    before do
      @books_count = 2
      visit shopper_engine.cart_path
      within('.quantity_form') do
        fill_in 'quantity', with: @books_count
        click_button 'Update'
      end
    end
    scenario "must change the cart sum in header" do
      expect(page).to have_content "Cart (#{@book.price * @books_count}$)"
    end
    scenario "must fill value in update quantity form" do
      visit shopper_engine.cart_path
      expect(page).to have_field('quantity', @books_count)
    end
  end
  feature "User changes quantity to 0 " do
    before do
      @books_count = 0
      visit shopper_engine.cart_path
      within('.quantity_form') do
        fill_in 'quantity', with: @books_count
        click_button 'Update'
      end
    end
    scenario "must change the cart sum in header" do
      expect(page).to have_content "Cart (0$)"
    end
    scenario "must remove item from cart" do
      expect(page).to_not have_content(@book.title)
    end
  end
end
