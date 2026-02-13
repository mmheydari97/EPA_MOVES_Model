# Build Stage
FROM debian:11 AS builder

# Install dependencies for building
RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    ant \
    golang \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

# Build Linux Go binaries
# The build.xml 'go' target builds all versions, we only need linux ones really, 
# but 'go' target is comprehensive.
# We also need to compile the java code? 'ant rungui' usually compiles if needed, 
# but better to pre-compile.
RUN ant compile

# Build Go binaries for Linux
# The build.xml 'go' target tries to build everything including windows .exe
# We just want the linux binaries. 
# Looking at build.xml: 
# <exec executable="go" spawn="false" dir="${user.dir}/calc/" output="gocalclinuxoutput.txt" ...>
# <arg value="externalcalculatorgo" /> (no extension)
# So we can run `ant go` but it might fail on windows parts.
# Let's try running `go build` directly for simplicity and reliability.
WORKDIR /app/calc
# Build externalcalculatorgo for linux
RUN go build -o externalcalculatorgo externalcalculatorgo.go

WORKDIR /app/generators
# Build externalgenerator for linux
RUN go build -mod=vendor -o externalgenerator externalgenerator.go

# Return to root
WORKDIR /app

# Runtime Stage
FROM jlesage/baseimage-gui:debian-11-v4

# Install runtime dependencies
RUN apt-get update && apt-get install -y \
    openjdk-11-jre \
    ant \
    mariadb-client \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy application from builder
COPY --from=builder /app /app

# Copy the startapp script which the base image looks for
COPY startapp.sh /startapp.sh
RUN chmod +x /startapp.sh

# Make sure scripts are executable
RUN chmod +x *.sh \
    && chmod +x calc/externalcalculatorgo \
    && chmod +x generators/externalgenerator

# Set environment variables
ENV APP_NAME="EPA MOVES Model"
ENV KEEP_APP_RUNNING=1

# The base image exposes port 5800 for web access
