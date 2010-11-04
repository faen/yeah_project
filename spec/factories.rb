Factory.define :user do |user|
  user.email                  "user@test.com"
  user.email_confirmation     "user@test.com"
  user.password               "password"
  user.password_confirmation  "password"
end