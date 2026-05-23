#!/bin/bash

INPUT_FASTQ="$1"
REFERENCE_GENOME="$2"

if [ $# -ne 2 ]; then
    echo "Usage: bash scripts/pipeline.sh <FASTQ_FILE> <REFERENCE_GENOME>"
    echo "Example: bash scripts/pipeline.sh data/raw/normal_R1.fastq.gz reference/phix.fa"
    exit 1
fi

if [ ! -f "$INPUT_FASTQ" ]; then
    echo "ERROR: FASTQ file not found: $INPUT_FASTQ"
    exit 1
fi

if [ ! -f "$REFERENCE_GENOME" ]; then
    echo "ERROR: Reference genome not found: $REFERENCE_GENOME"
    exit 1
fi

SAMPLE_NAME=$(basename "$INPUT_FASTQ" .fastq.gz)
SAMPLE_NAME=$(basename "$SAMPLE_NAME" .fastq)

TRIMMED_FASTQ="results/trim/${SAMPLE_NAME}_trimmed.fastq.gz"
SORTED_BAM="results/alignment/${SAMPLE_NAME}_sorted.bam"

echo "=================================================="
echo "STARTING BIOINFORMATICS PIPELINE WORKFLOW"
echo "Input FASTQ      : $INPUT_FASTQ"
echo "Reference Genome : $REFERENCE_GENOME"
echo "Sample Name      : $SAMPLE_NAME"
echo "=================================================="

echo "STEP 1: QC ANALYSIS"
bash scripts/qc.sh "$INPUT_FASTQ" || { echo "QC step failed!"; exit 1; }

echo "STEP 2: TRIMMING"
bash scripts/trim.sh "$INPUT_FASTQ" || { echo "Trimming step failed!"; exit 1; }

if [ ! -f "$TRIMMED_FASTQ" ]; then
    echo "ERROR: Trimmed FASTQ not found: $TRIMMED_FASTQ"
    exit 1
fi

echo "STEP 3: ALIGNMENT"
bash scripts/align.sh "$TRIMMED_FASTQ" "$REFERENCE_GENOME" || { echo "Alignment step failed!"; exit 1; }

if [ ! -f "$SORTED_BAM" ]; then
    echo "ERROR: Sorted BAM not found: $SORTED_BAM"
    exit 1
fi

echo "STEP 4: VARIANT CALLING"
bash scripts/variant_call.sh "$SORTED_BAM" "$REFERENCE_GENOME" || { echo "Variant calling step failed!"; exit 1; }

echo "=================================================="
echo "PIPELINE COMPLETED SUCCESSFULLY"
echo "QC Results        : results/qc/pre_trim"
echo "Trimmed FASTQ     : $TRIMMED_FASTQ"
echo "Alignment Results : results/alignment"
echo "Variant Results   : results/variants"
echo "Logs              : logs/"
echo "==================================================" 