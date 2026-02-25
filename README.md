# My Finances

A Rails application for personal finance management.

## Stack

- **Ruby**: 3.4.7
- **Rails**: 8.1.2
- **Database**: PostgreSQL 15
- **CSS**: Tailwind CSS 4

## Running with Docker

### Requirements

- Docker
- Docker Compose

### Starting the application

```bash
docker-compose up
```

The application will be available at: **http://localhost:3003**

### Setting up the database (first time only)

```bash
docker-compose run --rm web bin/rails db:create db:migrate db:seed
```

### Useful commands

```bash
# Start in background
docker-compose up -d

# View logs
docker-compose logs -f web

# Rails console
docker-compose run --rm web bin/rails console

# Run tests
docker-compose run --rm web bundle exec rspec

# Run migrations
docker-compose run --rm web bin/rails db:migrate

# Stop everything
docker-compose down
```

## Services and ports

| Service     | Host port | Container port |
|-------------|-----------|----------------|
| Web (Rails) | 3003      | 3000           |
| PostgreSQL  | 5532      | 5432           |
| Redis       | 6380      | 6379           |
