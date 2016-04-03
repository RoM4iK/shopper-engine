require 'rails_helper'

RSpec.describe ShopperEngine::OrderItem, type: :model do
  it { is_expected.to belong_to(:product) }
  it { is_expected.to belong_to(:order) }

  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_presence_of(:quantity) }

end
