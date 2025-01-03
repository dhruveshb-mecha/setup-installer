# Use Debian Bookworm as the base image
FROM debian:bookworm

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and install basic tools
RUN apt update && \
    apt install -y \
        sudo \
        bash \
        curl \
        nano && \
    # Clean up apt cache to reduce image size
    apt clean && rm -rf /var/lib/apt/lists/*

# Copy assets and setup script to the container
COPY assets /assets
COPY setup.sh /setup.sh

# Make setup script executable
RUN chmod +x /setup.sh

# Default command to run bash
CMD ["/bin/bash"]
