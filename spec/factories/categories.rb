FactoryBot.define do
  factory :category do
    # sequence garante nomes únicos
    sequence(:name) { |n| "Category #{n}" }

    # kind padrão: expense
    kind { :expense }

    # Cor aleatória (em produção, seria mais realista)
    color { "#ef4444" }

    # Descrição opcional (nil por padrão)
    description { nil }

    # Trait para categoria de receita
    trait :income do
      kind { :income }
    end

    # Trait para categoria de despesa
    trait :expense do
      kind { :expense }
    end

    # Trait com dados realistas (Faker)
    trait :with_fake_data do
      name { Faker::Commerce.department }
      description { Faker::Lorem.sentence(word_count: 5) }
    end

    # Trait para categorias padrão
    trait :alimentacao do
      name { "Alimentação" }
      description { "Supermercado, restaurantes, delivery" }
      color { "#ef4444" }
      kind { :expense }
    end

    trait :salario do
      name { "Salário" }
      description { "Renda do trabalho formal" }
      color { "#16a34a" }
      kind { :income }
    end
  end
end
