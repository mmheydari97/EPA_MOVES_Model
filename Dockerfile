FROM openjdk:11-jdk-slim

WORKDIR /app

# Install basic dependencies if needed (e.g., for some ant tasks or debugging)
RUN apt-get update && apt-get install -y \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Copy the entire repository into the container
COPY . /app

# Make scripts executable
RUN chmod +x *.sh \
    && chmod +x amazon/*.sh \
    && chmod +x calc/*.sh \
    && chmod +x generators/*.sh \
    && chmod +x database/Setup/*.sh \
    && chmod +x ant/bin/ant

# Set environment variables from setenv.sh mechanism or directly here
# We can source setenv.sh in the entrypoint or just set them globally
# For simplicity, let's default to running MOVESMain.sh
ENTRYPOINT ["./MOVESMain.sh"]
