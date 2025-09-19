#! /bin/bash

# full backup
mysqldump -u "$DB_USER" -p "$DB_PASSWORD" --databases ShopDB  --result-file=backup.full.sql --no-create-db
# restore from full backup
mysql -u "$USER" -p "$DB_PASSWORD" ShopDBDevelopment < backup.full.sql  

# data backup
mysqldump -u "$USER" -p "$DB_PASSWORD" --databases ShopDB --result-file=backup.data.sql --no-create-db --no-create-info;
# restore from data backup
mysql -u "$USER" -p "$DB_PASSWORD" ShopDBDevelopment < backup.data.sql

