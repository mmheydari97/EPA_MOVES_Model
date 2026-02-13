#!/bin/bash

# Set paths for ant and java
# Assuming the script is sourced, so variables persist in the current shell
# Use BASH_SOURCE to get the location of this script
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Add local ant and jre/bin to PATH if they exist
if [ -d "$SCRIPT_DIR/ant/bin" ]; then
    export PATH="$SCRIPT_DIR/ant/bin:$PATH"
fi

if [ -d "$SCRIPT_DIR/jre/bin" ]; then
    export PATH="$SCRIPT_DIR/jre/bin:$PATH"
    export JAVA_HOME="$SCRIPT_DIR/jre"
    export JRE_HOME="$SCRIPT_DIR/jre"
fi

if [ -d "$SCRIPT_DIR/tools" ]; then
    export PATH="$SCRIPT_DIR/tools:$PATH"
fi

export JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF-8"
export ANT_OPTS="-XX:-UseGCOverheadLimit"
