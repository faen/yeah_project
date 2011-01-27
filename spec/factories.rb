# Factory.define :user do |user|
#   user.email                  "user@test.com"
#   user.email_confirmation     "user@test.com"
#   user.password               "password"
#   user.password_confirmation  "password"
#   user.realms                 []
# end
require 'faker'
FactoryGirl.define do
  factory :user do
    email                  {Faker::Internet.email}
    email_confirmation     { email }
    password               "password"
    password_confirmation  { password }
  end
end

FactoryGirl.define do
  factory :realm do
    name                  Faker::Name.first_name
    user                  Factory(:user)
  end
end

FactoryGirl.define do
  factory :product do
    name                  Faker::Name.first_name
    user                  Factory(:user)
    realm                 Factory(:realm)
  end
end

