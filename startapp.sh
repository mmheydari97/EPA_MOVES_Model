#!/bin/sh
# This script is used by jlesage/baseimage-gui to start the application

cd /app

# Point to the database container
# We need to update MOVESConfiguration.txt to point to the db host
# We can do this with sed
sed -i 's/localhost/db/g' MOVESConfiguration.txt
sed -i 's/127.0.0.1/db/g' MOVESConfiguration.txt

# Start the application
./MOVESMain.sh
