# Shopper Engine
### Simple mountable shop engine, with cart and checkout features.
# Installation
## Database setup
1. Generate migrations by `rake shopper_engine:install:migrations`
2. Run migrations by `rake db:migrate`
## Customer model
1. Ensure that your model is valid Devise user model.
2. Call `acts_as_customer ` method inside it.
```
class Customer < ActiveRecord::Base
  ...
  acts_as_customer
end
```
## Products models
1. Ensure that you model have `title`, and `price` attributes.
2. Call `acts_as_product` method inside it.
```
class Book < ActiveRecord::Base
  ...
  acts_as_product
end
```
## Helpers
1. `shopper_engine.cart_path` - cart page url.
2. `shopper_engine.add_to_cart(product)` - add to cart button.

# Customization
You can customize views and controllers by creating a copy of them in your application.
##### Command for creating controllers copy:
`rails generate shopper_engine:controllers`
##### Command for creating views copy:
`rails generate shopper_engine:views`
