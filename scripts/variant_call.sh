#!/bin/bash

# ==========================================
# VARIANT CALLING PIPELINE (REAL VERSION)
# INPUT: sorted BAM from alignment pipeline
# OUTPUT: VCF
# ==========================================

if [ $# -ne 2 ]; then
    echo "Usage: ./variant_call.sh <sorted_bam> <reference.fa>"
    exit 1
fi

INPUT_BAM=$1
REFERENCE=$2

OUTDIR="results/variants"
LOGDIR="logs"

mkdir -p "$OUTDIR"
mkdir -p "$LOGDIR"

LOGFILE="$LOGDIR/variant_call.log"

SAMPLE_NAME=$(basename "$INPUT_BAM" _sorted.bam)
VCF_FILE="$OUTDIR/${SAMPLE_NAME}.vcf"

echo "==========================================" | tee -a "$LOGFILE"
echo "VARIANT CALLING STARTED" | tee -a "$LOGFILE"
echo "==========================================" | tee -a "$LOGFILE"

echo "Input BAM   : $INPUT_BAM" | tee -a "$LOGFILE"
echo "Reference   : $REFERENCE" | tee -a "$LOGFILE"

# ----------------------------
# CHECK INPUTS
# ----------------------------

if [ ! -f "$INPUT_BAM" ]; then
    echo "ERROR: BAM file not found" | tee -a "$LOGFILE"
    exit 1
fi

if [ ! -f "$REFERENCE" ]; then
    echo "ERROR: Reference genome not found" | tee -a "$LOGFILE"
    exit 1
fi

# ----------------------------
# INDEX BAM (if missing)
# ----------------------------

if [ ! -f "${INPUT_BAM}.bai" ]; then
    echo "Indexing BAM..." | tee -a "$LOGFILE"
    samtools index "$INPUT_BAM"
fi

# ----------------------------
# VARIANT CALLING (bcftools)
# ----------------------------

echo "Running bcftools mpileup..." | tee -a "$LOGFILE"

bcftools mpileup -f "$REFERENCE" "$INPUT_BAM" | \
bcftools call -mv -Ov -o "$VCF_FILE"

# ----------------------------
# DONE
# ----------------------------

echo "==========================================" | tee -a "$LOGFILE"
echo "VCF GENERATED: $VCF_FILE" | tee -a "$LOGFILE"
echo "VARIANT CALLING COMPLETED" | tee -a "$LOGFILE"
echo "==========================================" | tee -a "$LOGFILE"