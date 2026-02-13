#!/bin/bash
set -e

echo "Unzipping database file..."
# Navigate to the directory where the zip file is mounted
cd /docker-entrypoint-initdb.d/

if [ -f "movesdb20241112.zip" ]; then
    unzip -o movesdb20241112.zip
    # Now we have movesdb20241112.sql
    echo "Database unzipped."
else
    echo "Zip file not found!"
fi

# The maria docker entrypoint automatically runs .sql and .sh files in this directory.
# Since this script is .sh, it runs.
# We need to make sure the SQL files run AFTER this script if we rely on auto-execution?
# Actually, unzip extracts .sql files.
# If the .sql files are present when the entrypoint scans, they will be run.
# Docker entrypoint usually runs scripts in alphabetical order.
# I will name this `00-init-db.sh` so it runs first?
# Wait, if I unzip them here, does the entrypoint see them *dynamically*?
# Usually the entrypoint finds files at startup.
# Safer approach: Manually feed them to mysql inside this script.

echo "Running CreateMOVESUser.sql..."
mysql -u root -p"$MYSQL_ROOT_PASSWORD" < CreateMOVESUser.sql

echo "Running movesdb20241112.sql (this may take a while)..."
mysql -u root -p"$MYSQL_ROOT_PASSWORD" < movesdb20241112.sql

echo "Database initialization complete."
