require 'rails_helper'

RSpec.describe ShopperEngine::CreditCard, type: :model do
  it { is_expected.to belong_to :customer }
  it { is_expected.to have_many :orders }

  it { is_expected.to validate_presence_of(:number) }
  it { is_expected.to validate_presence_of(:cvv) }
  it { is_expected.to validate_presence_of(:expiration_month) }
  it { is_expected.to validate_presence_of(:expiration_year) }
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_uniqueness_of(:number) }
end
