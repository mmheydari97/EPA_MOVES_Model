#!/bin/bash

# Set paths relative to script location
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

export ANT_HOME="$SCRIPT_DIR/../ant"
export JAVA_HOME="$SCRIPT_DIR/../jre"
export CLASSPATH=""

export PATH="$JAVA_HOME/bin:$ANT_HOME/bin:$PATH"
