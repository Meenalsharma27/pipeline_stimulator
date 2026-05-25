#!/bin/bash

# ================================================================
#                ALIGNMENT PIPELINE : BWA + SAMTOOLS
# ================================================================
#
# DESCRIPTION:
#   This script performs sequence alignment of trimmed
#   FASTQ reads against a reference genome using:
#
#       1. BWA MEM
#       2. SAMTOOLS
#
# ------------------------------------------------
# REQUIRED DEPENDENCIES
# ------------------------------------------------
#
# Install:
#
#   sudo apt install bwa samtools
#
# OR using conda:
#
#   conda install -c bioconda bwa samtools
#
# ------------------------------------------------
# USAGE
# ------------------------------------------------
#
#   chmod +x align.sh
#
#   ./align.sh sample_trimmed.fastq.gz reference/genome.fa
#
# ------------------------------------------------
# OUTPUT
# ------------------------------------------------
#
#   results/alignment/
#
#       sample.sam
#       sample.bam
#       sample_sorted.bam
#       sample_sorted.bam.bai
#
# ------------------------------------------------
# AUTHOR
# ------------------------------------------------
#   Bioinformatics Alignment Module
#
# ================================================================


# ================================================================
# CHECK INPUT ARGUMENTS
# ================================================================

if [ $# -ne 2 ]; then
    echo "=================================================="
    echo "ERROR: Invalid number of arguments"
    echo "Usage:"
    echo "    ./align.sh <TRIMMED_FASTQ> <REFERENCE_GENOME>"
    echo ""
    echo "Example:"
    echo "    ./align.sh sample_trimmed.fastq.gz genome.fa"
    echo "=================================================="
    exit 1
fi


# ================================================================
# INPUT FILES
# ================================================================

INPUT_FASTQ="$1"
REFERENCE="$2"


# ================================================================
# DIRECTORY STRUCTURE
# ================================================================

OUTDIR="results/alignment"
LOGDIR="logs"


# ================================================================
# LOG FILE
# ================================================================

LOGFILE="$LOGDIR/alignment.log"


# ================================================================
# CREATE DIRECTORIES
# ================================================================

mkdir -p "$OUTDIR"
mkdir -p "$LOGDIR"


# ================================================================
# START LOGGING
# ================================================================

echo "==================================================" | tee -a "$LOGFILE"
echo "             ALIGNMENT PIPELINE STARTED           " | tee -a "$LOGFILE"
echo "==================================================" | tee -a "$LOGFILE"
echo "Date            : $(date)" | tee -a "$LOGFILE"
echo "Input FASTQ     : $INPUT_FASTQ" | tee -a "$LOGFILE"
echo "Reference Genome: $REFERENCE" | tee -a "$LOGFILE"
echo "Output Directory: $OUTDIR" | tee -a "$LOGFILE"
echo "Log File        : $LOGFILE" | tee -a "$LOGFILE"
echo "==================================================" | tee -a "$LOGFILE"


# ================================================================
# CHECK INPUT FILES EXIST
# ================================================================

if [ ! -f "$INPUT_FASTQ" ]; then
    echo "ERROR: Trimmed FASTQ file not found!" | tee -a "$LOGFILE"
    exit 1
fi

if [ ! -f "$REFERENCE" ]; then
    echo "ERROR: Reference genome not found!" | tee -a "$LOGFILE"
    exit 1
fi


# ================================================================
# CHECK BWA INSTALLATION
# ================================================================

if ! command -v bwa &> /dev/null
then
    echo "ERROR: BWA is not installed!" | tee -a "$LOGFILE"
    echo "Install using: sudo apt install bwa" | tee -a "$LOGFILE"
    exit 1
fi


# ================================================================
# CHECK SAMTOOLS INSTALLATION
# ================================================================

if ! command -v samtools &> /dev/null
then
    echo "ERROR: SAMTOOLS is not installed!" | tee -a "$LOGFILE"
    echo "Install using: sudo apt install samtools" | tee -a "$LOGFILE"
    exit 1
fi


# ================================================================
# EXTRACT SAMPLE NAME
# ================================================================

SAMPLE_NAME=$(basename "$INPUT_FASTQ" _trimmed.fastq.gz)
SAMPLE_NAME=$(basename "$SAMPLE_NAME" .fastq.gz)

echo "Sample Name     : $SAMPLE_NAME" | tee -a "$LOGFILE"


# ================================================================
# OUTPUT FILES
# ================================================================

SAM_FILE="$OUTDIR/${SAMPLE_NAME}.sam"

BAM_FILE="$OUTDIR/${SAMPLE_NAME}.bam"

SORTED_BAM="$OUTDIR/${SAMPLE_NAME}_sorted.bam"


# ================================================================
# INDEX REFERENCE GENOME
# ================================================================

echo "==================================================" | tee -a "$LOGFILE"
echo "INDEXING REFERENCE GENOME..." | tee -a "$LOGFILE"
echo "==================================================" | tee -a "$LOGFILE"

bwa index "$REFERENCE" 2>> "$LOGFILE"

if [ $? -ne 0 ]; then
    echo "ERROR: Reference genome indexing failed!" | tee -a "$LOGFILE"
    exit 1
fi

echo "Reference indexing completed." | tee -a "$LOGFILE"


# ================================================================
# RUN BWA MEM ALIGNMENT
# ================================================================

echo "==================================================" | tee -a "$LOGFILE"
echo "RUNNING BWA MEM ALIGNMENT..." | tee -a "$LOGFILE"
echo "==================================================" | tee -a "$LOGFILE"

bwa mem "$REFERENCE" "$INPUT_FASTQ" > "$SAM_FILE" 2>> "$LOGFILE"

if [ $? -ne 0 ]; then
    echo "ERROR: BWA MEM alignment failed!" | tee -a "$LOGFILE"
    exit 1
fi

echo "Alignment completed successfully." | tee -a "$LOGFILE"


# ================================================================
# CONVERT SAM TO BAM
# ================================================================

echo "==================================================" | tee -a "$LOGFILE"
echo "CONVERTING SAM TO BAM..." | tee -a "$LOGFILE"
echo "==================================================" | tee -a "$LOGFILE"

samtools view -Sb "$SAM_FILE" > "$BAM_FILE" 2>> "$LOGFILE"

if [ $? -ne 0 ]; then
    echo "ERROR: SAM to BAM conversion failed!" | tee -a "$LOGFILE"
    exit 1
fi

echo "BAM conversion completed." | tee -a "$LOGFILE"


# ================================================================
# SORT BAM FILE
# ================================================================

echo "==================================================" | tee -a "$LOGFILE"
echo "SORTING BAM FILE..." | tee -a "$LOGFILE"
echo "==================================================" | tee -a "$LOGFILE"

samtools sort "$BAM_FILE" -o "$SORTED_BAM" 2>> "$LOGFILE"

if [ $? -ne 0 ]; then
    echo "ERROR: BAM sorting failed!" | tee -a "$LOGFILE"
    exit 1
fi

echo "BAM sorting completed." | tee -a "$LOGFILE"


# ================================================================
# INDEX SORTED BAM
# ================================================================

echo "==================================================" | tee -a "$LOGFILE"
echo "INDEXING SORTED BAM..." | tee -a "$LOGFILE"
echo "==================================================" | tee -a "$LOGFILE"

samtools index "$SORTED_BAM" 2>> "$LOGFILE"

if [ $? -ne 0 ]; then
    echo "ERROR: BAM indexing failed!" | tee -a "$LOGFILE"
    exit 1
fi

echo "BAM indexing completed." | tee -a "$LOGFILE"


# ================================================================
# VERIFY OUTPUT
# ================================================================

if [ ! -f "$SORTED_BAM" ]; then
    echo "ERROR: Sorted BAM file not generated!" | tee -a "$LOGFILE"
    exit 1
fi


# ================================================================
# FINAL SUCCESS MESSAGE
# ================================================================

echo "==================================================" | tee -a "$LOGFILE"
echo "        ALIGNMENT PIPELINE COMPLETED              " | tee -a "$LOGFILE"
echo "==================================================" | tee -a "$LOGFILE"
echo "Sample Processed : $SAMPLE_NAME" | tee -a "$LOGFILE"
echo "SAM File         : $SAM_FILE" | tee -a "$LOGFILE"
echo "BAM File         : $BAM_FILE" | tee -a "$LOGFILE"
echo "Sorted BAM       : $SORTED_BAM" | tee -a "$LOGFILE"
echo "BAM Index        : ${SORTED_BAM}.bai" | tee -a "$LOGFILE"
echo "Log File         : $LOGFILE" | tee -a "$LOGFILE"
echo "Completion Time  : $(date)" | tee -a "$LOGFILE"
echo "==================================================" | tee -a "$LOGFILE"
