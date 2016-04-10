class Customer < ActiveRecord::Base
  devise :database_authenticatable, :registerable
  acts_as_customer scope: :customer
end
