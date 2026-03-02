FactoryBot.define do
  factory :user do
    # Use sequence to guarantee unique emails across tests
    # (user1@example.com, user2@example.com, etc)
    sequence(:name) { |n| "User #{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }

    # Devise requires password + password_confirmation for validations
    password { "SecurePassword123!" }
    password_confirmation { "SecurePassword123!" }

    # Default role is member, can be overridden with trait
    role { :member }

    # Trait for creating admin users
    trait :admin do
      role { :admin }
    end

    # Trait to use realistic fake data (Faker)
    trait :with_fake_data do
      name { Faker::Name.name }
      email { Faker::Internet.unique.email }
    end
  end
end
