#!/bin/bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

export GOPATH="$SCRIPT_DIR/go"
export GOROOT="$SCRIPT_DIR/go"

if [ -d "$SCRIPT_DIR/go/src" ]; then
    cd "$SCRIPT_DIR/go/src"
fi

export PATH="$GOROOT/bin:$PATH"

godoc -v -http=":6060"
