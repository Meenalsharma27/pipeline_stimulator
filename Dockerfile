FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Set working directory
WORKDIR /app

# Install required tools
RUN apt-get update && apt-get install -y \
    bash \
    wget \
    curl \
    unzip \
    zip \
    gzip \
    nano \
    vim \
    default-jre \
    python3 \
    python3-pip \
    fastqc \
    fastp \
    bwa \
    samtools \
    bcftools \
    && rm -rf /var/lib/apt/lists/*

# Copy all project files
COPY . /app

# Give execute permission to scripts
RUN chmod +x scripts/*.sh

# Create required folders
RUN mkdir -p \
    results/qc/pre_trim \
    results/trim \
    results/alignment \
    results/variants \
    logs

# Run pipeline by default
ENTRYPOINT ["bash", "scripts/pipeline.sh"]