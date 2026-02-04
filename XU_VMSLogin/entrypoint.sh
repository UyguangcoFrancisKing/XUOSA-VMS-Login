#!/bin/bash

echo "Waiting for MySQL at db:3306..."
while ! nc -z mysqldb 3306; do
  sleep 1
done
echo "MySQL is up!"

mkdir -p /app/staticfiles /app/static

python manage.py collectstatic --noinput
python manage.py makemigrations --noinput
python manage.py migrate --noinput

python -m gunicorn --bind 0.0.0.0:8001 --workers 3 XU_VMSLogin.wsgi:application