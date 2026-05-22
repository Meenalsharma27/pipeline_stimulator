FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app

RUN apt-get update && apt-get install -y \
    bash \
    fastqc \
    bwa \
    samtools \
    bcftools \
    && rm -rf /var/lib/apt/lists/*

COPY . /app

RUN chmod +x scripts/*.sh

RUN mkdir -p results/qc/pre_trim \
    results/trim \
    results/alignment \
    results/variants \
    logs

ENTRYPOINT ["bash", "scripts/pipeline.sh"]