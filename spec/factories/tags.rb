FactoryBot.define do
  factory :tag do

    sequence(:name) { |n| "Tag #{n}" }


    color { "#ef4444" }


    description { nil }


    trait :with_fake_data do
      name { Faker::Lorem.word }
      description { Faker::Lorem.sentence(word_count: 5) }
    end


    trait :essencial do
      name { "essencial" }
      description { "Gastos essenciais do mês" }
      color { "#ef4444" }
    end

    trait :semanal do
      name { "semanal" }
      description { "Gastos semanais" }
      color { "#3b82f6" }
    end

    trait :emergencia do
      name { "emergência" }
      description { "Gastos de emergência" }
      color { "#dc2626" }
    end
  end
end