require 'rails_helper'


RSpec.describe ShopperEngine::Address, type: :model do
  it { is_expected.to belong_to(:country) }

  it { is_expected.to validate_presence_of(:address) }
  it { is_expected.to validate_presence_of(:zipcode) }
  it { is_expected.to validate_presence_of(:city) }
  it { is_expected.to validate_presence_of(:phone) }
  it { is_expected.to validate_presence_of(:country) }
end
