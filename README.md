# Silent Dose

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nec pur.

## Technologies

`Ruby 3.2.5`, `Rails 7.2`, `Hotwire`, `Docker`, `PostgreSQL`, `Redis`, `Sidekiq`, `Devise`, `Pundit`, `ActiveAdmin`.

## Development

Install gems:
```bash
bundle install
```

Run the development docker compose:
```bash
docker compose up -d --remove-orphans
```

Copy `.env.development.template` to `.env.development` and fill in the values.

Create the database, run the migrations and seed the database:
```bash
rails db:reset

# or

rails db:create
rails db:migrate
rails db:seed
```

Start the application:
```bash
./bin/dev
```

## Deploying to Production using Docker Compose

Clone the repository.

Copy `.env.production.template` to `.env.production` and fill in the values.

Create the database:
```bash
docker compose -f docker-compose.prod.yml up -d db
docker compose -f docker-compose.prod.yml exec -it db bash
psql -U postgres
CREATE DATABASE "silent-dose_production";
docker compose -f docker-compose.prod.yml down
```

Start the application:
```bash
docker compose -f docker-compose.prod.yml build
docker compose -f docker-compose.prod.yml up -d --remove-orphans
```

Stop the application:
```bash
docker compose -f docker-compose.prod.yml down
```

With every new version of the application, you have to rebuild the image and restart the container.
```bash
git pull
docker compose -f docker-compose.prod.yml up -d --remove-orphans --build
```
