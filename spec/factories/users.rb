FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { "Password123!" }
    password_confirmation { "Password123!" }
    role { :member }
  end

  # Admin user factory
  trait :admin do
    role { :admin }
  end
end
