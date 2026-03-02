# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).



admin = User.find_or_create_by!(email: "admin@myfinances.local") do |user|
  user.name = "Administrador"
  user.password = "Admin123!"
  user.role = :admin
end
puts "--Admin criado: #{admin.email}"

member = User.find_or_create_by!(email: "member@myfinances.local") do |user|
  user.name = "Usuário Teste"
  user.password = "Member123!"
  user.role = :member
end
puts "--Member criado: #{member.email}"




expense_categories = [
  { name: "Alimentação", color: "#ef4444", description: "Supermercado, restaurantes, delivery" },
  { name: "Transporte", color: "#f97316", description: "Combustível, transporte público, Uber" },
  { name: "Saúde", color: "#22c55e", description: "Consultas, medicamentos, plano de saúde" },
  { name: "Lazer", color: "#a855f7", description: "Cinema, viagens, entretenimento" },
  { name: "Educação", color: "#3b82f6", description: "Cursos, livros, faculdade" },
  { name: "Moradia", color: "#78716c", description: "Aluguel, condomínio, IPTU" },
  { name: "Vestuário", color: "#ec4899", description: "Roupas, calçados, acessórios" },
  { name: "Assinaturas", color: "#06b6d4", description: "Netflix, Spotify, serviços recorrentes" },
]


income_categories = [
  { name: "Salário", color: "#16a34a", description: "Renda do trabalho formal" },
  { name: "Freelance", color: "#65a30d", description: "Trabalhos autônomos" },
  { name: "Investimentos", color: "#eab308", description: "Dividendos, rendimentos" },
  { name: "Outros", color: "#94a3b8", description: "Receitas diversas" },
]

expense_categories.each do |attrs|
  Category.find_or_create_by!(name: attrs[:name]) do |category|
    category.assign_attributes(attrs.merge(kind: :expense))
  end
end
puts "✓ #{expense_categories.length} categorias de despesa criadas"

income_categories.each do |attrs|
  Category.find_or_create_by!(name: attrs[:name]) do |category|
    category.assign_attributes(attrs.merge(kind: :income))
  end
end
puts "#{income_categories.length} categorias de receita criadas"

puts "\n✅ Seeds completadas!"
puts "Acesse com: admin@myfinances.local / Admin123!"
puts "            member@myfinances.local / Member123!"