shared_context "checkout_context" do
  before do
    @book = FactoryGirl.create(:book)
    @customer = FactoryGirl.create(:customer)
    login_as(@customer, :scope => :customer)
    visit root_path
    within('.add-to-cart-button') do
      click_button 'Buy'
    end
    visit cart_path
    click_link 'Checkout'
  end
end
