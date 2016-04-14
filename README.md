# Shopper Engine
### Simple mountable shop engine, with cart and checkout features.
# Installation
## Database setup
1. Generate migrations by `rake shopper_engine:install:migrations`
2. Run migrations by `rake db:migrate`
## Customer model
1. Ensure that your model is valid Devise user model.
2. Call `acts_as_customer ` method inside it, if class name different then `User`, you must pass it to method.
```
class Customer < ActiveRecord::Base
  ...
  acts_as_customer :customer
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
## Customization
You can customize views and controllers by creating a copy of them in your application.
##### Command for creating controllers copy:
`rails generate shopper_engine:controllers`
##### Command for creating views copy:
`rails generate shopper_engine:views`
