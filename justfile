# Justfile para My Finances
# Use: `just <comando>` ou `jj <comando>`

# Instalar dependências
install:
    bundle install

# Verificar se as gems estão instaladas
check:
    bundle check

# Iniciar o servidor de desenvolvimento
dev:
    bin/dev

# Iniciar apenas o servidor Rails (sem Tailwind watch)
server:
    bin/rails server -b 0.0.0.0

# Preparar o banco de dados
db-setup:
    bin/rails db:create db:migrate db:seed

# Resetar o banco de dados
db-reset:
    bin/rails db:reset

# Rodar migrações
db-migrate:
    bin/rails db:migrate

# Rodar testes
test:
    bundle exec rspec

# Rodar linter
lint:
    bundle exec rubocop

# Rodar setup completo
setup:
    bundle install
    bin/rails db:prepare

# Iniciar com Docker Compose
docker-up:
    docker-compose up

# Parar Docker Compose
docker-down:
    docker-compose down

# Ver logs do Docker
docker-logs:
    docker-compose logs -f web

# Console Rails
console:
    bin/rails console

# Ver rotas
routes:
    bin/rails routes

# Limpar logs e cache
clean:
    bin/rails log:clear tmp:clear
