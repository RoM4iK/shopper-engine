require 'rails_helper'

feature "Add do cart" do
  before do
    @book = FactoryGirl.create(:book)
  end
  context "user adds 1 item to cart" do
    before do
      visit root_path
      within('.add-to-cart-button') do
        click_button 'Add to cart'
      end
    end
    scenario "must change the cart sum in header" do
      expect(page).to have_content "Cart (#{@book.price}$)"
    end
    scenario "must show success alert" do
      expect(page).to have_selector('.alert-success')
    end
    scenario "must store item in cart" do
      click_link("cart")
      expect(page).to have_content(@book.title)
    end
  end
  context "user adds 'n' item to cart" do
    before do
      BOOK_COUNT = 10
      visit root_path
      within("#add_to_cart_button_#{@book.id}") do
        fill_in 'quantity', with: BOOK_COUNT
        click_button 'Add to cart'
      end
    end
    scenario "must change the cart sum in header" do
      expect(page).to have_content "Cart (#{@book.price * BOOK_COUNT}$)"
    end
  end
end
