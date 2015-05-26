FactoryGirl.define do
  factory :role do
  	user_ids []
    name nil
  end

  factory :admin_role, parent: :role do
    name 'admin'
  end
end
