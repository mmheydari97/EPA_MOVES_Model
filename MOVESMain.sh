#!/bin/bash

# Source environment variables
source ./setenv.sh

# Cleanup sharedwork and WorkerFolder
if [ -d "sharedwork" ]; then
    rm -rf sharedwork/*
fi

if [ -d "WorkerFolder" ]; then
    rm -rf WorkerFolder/*
fi

# Generate timestamp for logfile
# Windows format: moveslog_archive_%date:~10,4%-%date:~4,2%-%date:~7,2%_%HR%%time:~3,2%.txt
# Equivalent to YYYY-MM-DD_HHMM
TIMESTAMP=$(date +"%Y-%m-%d_%H%M")
LOGFILE="moveslog_archive_$TIMESTAMP.txt"

# Archive previous moveslog.txt
if [ -f "moveslog.txt" ]; then
    mv "moveslog.txt" "$LOGFILE"
    
    if [ -f "$LOGFILE" ]; then
        if [ ! -f "moveslog.zip" ]; then
            # Check if jar command is available, otherwise try zip
            if command -v jar &> /dev/null; then
                jar cMf moveslog.zip "$LOGFILE" && rm "$LOGFILE"
            elif command -v zip &> /dev/null; then
                zip -m moveslog.zip "$LOGFILE"
            else
                echo "Warning: neither jar nor zip found. Leaving $LOGFILE uncompressed."
            fi
        else
             if command -v jar &> /dev/null; then
                jar uMf moveslog.zip "$LOGFILE" && rm "$LOGFILE"
            elif command -v zip &> /dev/null; then
                zip -ur moveslog.zip "$LOGFILE" && rm "$LOGFILE"
            else
                echo "Warning: neither jar nor zip found. Leaving $LOGFILE uncompressed."
            fi
        fi
    fi
fi

# Run ant task
ant rungui
