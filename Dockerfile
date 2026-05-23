FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Set working directory
WORKDIR /app

# Install required bioinformatics tools and utilities
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

# Install MultiQC using pip
RUN pip3 install multiqc

# Copy all project files into container
COPY . /app

# Give execute permission to shell scripts
RUN chmod +x scripts/*.sh

# Create required output directories
RUN mkdir -p \
    results/qc/pre_trim \
    results/trim \
    results/alignment \
    results/variants \
    logs

# Default pipeline execution
ENTRYPOINT ["bash", "scripts/pipeline.sh"]