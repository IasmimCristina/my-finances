# My Finances

A Rails application for personal finance management. - Studies for mentorship.

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
docker compose up
```

The application will be available at: **http://localhost:3003**

### Setting up the database (first time only)

```bash
docker compose run --rm web bin/rails db:create db:migrate db:seed
```

## Services and ports

| Service     | Host port | Container port |
| ----------- | --------- | -------------- |
| Web (Rails) | 3003      | 3000           |
| PostgreSQL  | 5532      | 5432           |
| Redis       | 6380      | 6379           |
