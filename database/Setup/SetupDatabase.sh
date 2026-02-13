#!/bin/bash

# Execute from the directory where proper sql files are located
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd "$SCRIPT_DIR"

mysql -uroot -pmoves --force < CreateMOVESUser.sql
mysql -uroot -pmoves < movesdb20241112.sql
