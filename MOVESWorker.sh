#!/bin/bash

# Source environment variables
source ./setenv.sh

# Cleanup WorkerFolder
if [ -d "WorkerFolder" ]; then
    rm -rf WorkerFolder/*
fi

# Run ant worker task
ant runworker
