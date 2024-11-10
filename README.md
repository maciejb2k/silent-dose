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

## Backup and Restore the Database

### Manual Backup and Restore

To backup the database, use the following command on the running container:
```bash
docker compose -f docker-compose.prod.yml exec -it db pg_dump -U postgres silent-dose_production > pgdump-$(date +%F_%H-%M-%S).dump
```

To restore the database, use the following commands on the running container:
```bash
# Terminate all connections to the database, to make drop possible
docker compose exec -it db psql -U postgres -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = 'silent-dose_production' AND pid != pg_backend_pid() AND leader_pid IS NULL;"
# Drop the database, must be in a separate command, because DROP DATABASE cannot be executed in a transaction block
docker compose exec -it db psql -U postgres -c "DROP DATABASE IF EXISTS \"silent-dose_production\";"
# Create a new database
docker compose exec -it db psql -U postgres -c "CREATE DATABASE \"silent-dose_production\" ENCODING UTF8;"
# Restore the database from the dump
docker compose -f docker-compose.prod.yml exec -T db bash -c "pg_restore -U postgres -v -d silent-dose_production" < pgdump.dump
```

### Automated Backup and Restore

You can also use the `./db_backup.sh` and `./db_restore.sh` scripts to backup and restore the database.

If the scripts are not executable, make them executable:
```bash
chmod +x backup.sh restore.sh
```

Backup with `db_backup.sh` to current location:
```bash
./db_backup.sh
```

Backup with `db_backup.sh` to a specific location:
```bash
./db_backup.sh /path/to/backup
./db_backup.sh /backups
./db_backup.sh ..
```

Restore with `db_restore.sh` without arguments and with prompt:
```bash
./db_restore.sh
```

Restore with `db_restore.sh` using arguments:
```bash
./db_restore.sh my_database /path/to/backup-file.dump
```
