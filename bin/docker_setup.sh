echo "=== Starting project setup for docker development environment ==="

echo "=== Setuping Web ==="
# cp --no-clobber config/database.yml.sample config/database.yml
# cp --no-clobber .env.sample .env
chown $USER config/database.yml

echo "=== Building containers ==="
docker-compose build sst --no-cache

docker-compose run --rm sst ./bin/db_setup.sh

echo "Setup Finished!"
