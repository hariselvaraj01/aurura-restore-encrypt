#!/bin/bash

DB_HOST=$1
DB_NAME=$2
DB_USER=$3
DB_PASS=$4
TABLE_NAME=$5
COLUMNS=$6
ENCRYPTION_KEY=$7

mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" < scripts/encrypt_column_proc.sql

mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" -e "CALL encrypt_columns('$TABLE_NAME', '$COLUMNS', '$ENCRYPTION_KEY');"
