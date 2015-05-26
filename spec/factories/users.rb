FactoryGirl.define do
  factory :user do
    email       "user@example.com"
    password    "foobar1234"
    role_ids    []
  end
  factory :admin_user, parent: :user do
    role_ids [123]
  end
end
