#!/bin/sh
# This script is used by jlesage/baseimage-gui to start the application

cd /app

# Point to the database container
# We need to update MOVESConfiguration.txt to point to the db host
# We can do this with sed
sed -i 's/localhost/db/g' MOVESConfiguration.txt
sed -i 's/127.0.0.1/db/g' MOVESConfiguration.txt

# Fix binary paths for Linux
sed -i 's|generators\\\\externalgenerator64.exe|generators/externalgenerator|g' MOVESConfiguration.txt
# NONROAD is Windows-only, so we ideally should disable it or point to a dummy if needed. 
# For now, let's just leave it as is, or maybe empty it?
# SystemConfiguration.java handles null.
# sed -i 's|nonroadExePath = .*|nonroadExePath = |g' MOVESConfiguration.txt

# Wait for MariaDB to be ready
echo "Waiting for MariaDB to be ready..."
until mysqladmin ping -h db --silent; do
    echo "DB is unavailable - sleeping"
    sleep 5
done
echo "DB is up!"

# Start the application
./MOVESMain.sh
