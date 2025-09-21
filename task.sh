#! /bin/bash

check_var() {
        var_name="$1"
        var_value="${!var_name}"
        if [ -z "$var_value" ]; then
                echo "Fehler!"
                exit 1
        fi
}

# Variables check
check_var "DB_USER"
check_var "DB_PASSWORD"

echo "All variables exist..."

# full backup
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --single-transaction --quick ShopDB  --result-file=backup.full.sql --no-create-db
# restore from full backup
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < backup.full.sql
# data backup
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --single-transaction --quick ShopDB --result-file=backup.data.sql --no-create-db --no-create-info --skip-triggers
# restore from data backup
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < backup.data.sql