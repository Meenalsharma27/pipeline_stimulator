#!/bin/bash

# ==========================================
# VARIANT CALLING PIPELINE
# ==========================================

# CHECK INPUT ARGUMENT

if [ $# -ne 1 ]; then
    echo "=================================================="
    echo "ERROR: Invalid number of arguments"
    echo "Usage:"
    echo "    ./variant_call.sh <SAM_FILE>"
    echo ""
    echo "Example:"
    echo "    ./variant_call.sh results/alignment/sample.sam"
    echo "=================================================="
    exit 1
fi

# INPUT FILE

INPUT=$1

# DIRECTORIES

OUTDIR="results/variants"
LOGDIR="logs"

mkdir -p "$OUTDIR"
mkdir -p "$LOGDIR"

# LOG FILE

LOGFILE="$LOGDIR/variant_call.log"

# SAMPLE NAME

SAMPLE_NAME=$(basename "$INPUT" .sam)

# OUTPUT FILE

VCF_FILE="$OUTDIR/${SAMPLE_NAME}.vcf"

# START LOGGING

echo "==================================================" | tee -a "$LOGFILE"
echo "VARIANT CALLING PIPELINE STARTED" | tee -a "$LOGFILE"
echo "==================================================" | tee -a "$LOGFILE"

echo "Input SAM File : $INPUT" | tee -a "$LOGFILE"
echo "Sample Name    : $SAMPLE_NAME" | tee -a "$LOGFILE"

# CHECK INPUT EXISTS

if [ ! -f "$INPUT" ]; then
    echo "ERROR: SAM file not found!" | tee -a "$LOGFILE"
    exit 1
fi

# SIMULATE VARIANT CALLING

echo "Running variant calling..." | tee -a "$LOGFILE"

sleep 2

# GENERATE DUMMY VCF

cat <<EOF > "$VCF_FILE"
##fileformat=VCFv4.2
#CHROM POS ID REF ALT QUAL FILTER INFO
chr1 105 . A T 99 PASS .
chr1 210 . G C 85 PASS .
chr2 450 . T G 92 PASS .
EOF

echo "Variant calling completed." | tee -a "$LOGFILE"

echo "VCF File : $VCF_FILE" | tee -a "$LOGFILE"

echo "==================================================" | tee -a "$LOGFILE"
echo "VARIANT CALLING COMPLETED SUCCESSFULLY" | tee -a "$LOGFILE"
echo "==================================================" | tee -a "$LOGFILE"