#!/bin/bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Assuming go is in calc/go relative to this script
export GOPATH="$SCRIPT_DIR/go"
# GOROOT is typically the Go installation directory. 
# If they have a local go distribution in calc/go, then fine.
# But often GOROOT shouldn't be set if using system Go.
# The original script sets it: set GOROOT=C:\EPA\MOVES\MOVESGHGSource\calc\go
# I'll replicate that behavior but with relative path
export GOROOT="$SCRIPT_DIR/go"

# cd to src? The original script does: cd C:\EPA\MOVES\MOVESGHGSource\calc\go\src
if [ -d "$SCRIPT_DIR/go/src" ]; then
    cd "$SCRIPT_DIR/go/src"
fi

# Run godoc
# Note: godoc might not be in the path if we just set GOROOT/GOPATH custom
# We might need to add $GOROOT/bin to PATH
export PATH="$GOROOT/bin:$PATH"

godoc -v -http=":6060"
