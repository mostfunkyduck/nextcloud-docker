set -ex

docker build -t yaakov/nextcloud:latest .
docker-compose restart -d
