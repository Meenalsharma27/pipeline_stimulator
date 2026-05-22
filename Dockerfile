FROM ubuntu:22.04

# ------------------------------------------------
# PREVENT INTERACTIVE PROMPTS
# ------------------------------------------------
ENV DEBIAN_FRONTEND=noninteractive

# ------------------------------------------------
# SET WORKING DIRECTORY
# ------------------------------------------------
WORKDIR /app

# ------------------------------------------------
# INSTALL SYSTEM + BIOINFORMATICS TOOLS
# ------------------------------------------------
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
    bwa \
    samtools \
    bcftools \
    trimmomatic \
    && rm -rf /var/lib/apt/lists/*

# ------------------------------------------------
# INSTALL MULTIQC
# ------------------------------------------------
RUN pip3 install multiqc

# ------------------------------------------------
# VERIFY INSTALLATIONS
# ------------------------------------------------
RUN fastqc --version && \
    multiqc --version && \
    bwa 2>&1 | head -n 1 && \
    samtools --version | head -n 1 && \
    bcftools --version | head -n 1 && \
    trimmomatic -version || true

# ------------------------------------------------
# COPY PROJECT FILES
# ------------------------------------------------
COPY . /app

# ------------------------------------------------
# MAKE SHELL SCRIPTS EXECUTABLE
# ------------------------------------------------
RUN chmod +x scripts/*.sh

# ------------------------------------------------
# CREATE REQUIRED OUTPUT DIRECTORIES
# ------------------------------------------------
RUN mkdir -p \
    results/qc/pre_trim \
    results/trim \
    results/alignment \
    results/variants \
    logs

# ------------------------------------------------
# DEFAULT PIPELINE EXECUTION
# ------------------------------------------------
ENTRYPOINT ["bash", "scripts/pipeline.sh"]