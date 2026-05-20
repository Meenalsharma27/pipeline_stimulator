#!/bin/bash

# ==========================================
# SIMULATED ALIGNMENT PIPELINE
# ==========================================

INPUT="results/trimmed/normal_R1_trimmed.fastq.gz"

REFERENCE="reference/genome.fa"

OUTDIR="results/alignment"

LOGDIR="logs"

LOGFILE="$LOGDIR/alignment.log"

mkdir -p $OUTDIR
mkdir -p $LOGDIR
mkdir -p reference

echo "===================================" | tee -a $LOGFILE
echo "ALIGNMENT PIPELINE STARTED" | tee -a $LOGFILE
echo "Date: $(date)" | tee -a $LOGFILE
echo "Input File: $INPUT" | tee -a $LOGFILE
echo "Reference Genome: $REFERENCE" | tee -a $LOGFILE
echo "===================================" | tee -a $LOGFILE

# CHECK INPUT FILE
if [ ! -f "$INPUT" ]; then
    echo "ERROR: Trimmed FASTQ file not found!" | tee -a $LOGFILE
    exit 1
fi

echo "Simulating genome indexing..." | tee -a $LOGFILE

sleep 2

echo "Simulating sequence alignment..." | tee -a $LOGFILE

sleep 2

echo "Generating SAM file..." | tee -a $LOGFILE

# CREATE DUMMY SAM FILE

cat <<EOF > $OUTDIR/aligned.sam
@HD	VN:1.6	SO:coordinate
@SQ	SN:chr1	LN:248956422
READ001	0	chr1	1000	60	50M	*	0	0	ATGCATGCATGCATGCATGC	IIIIIIIIIIIIIIIIIIII
EOF

echo "Converting SAM to BAM..." | tee -a $LOGFILE

sleep 2

# CREATE DUMMY BAM FILE

echo "SIMULATED BAM FILE CONTENT" \
> $OUTDIR/aligned.bam

echo "Sorting BAM file..." | tee -a $LOGFILE

sleep 2

echo "Creating BAM index..." | tee -a $LOGFILE

# CREATE DUMMY BAI FILE

echo "SIMULATED BAM INDEX" \
> $OUTDIR/aligned.bam.bai

echo "===================================" | tee -a $LOGFILE
echo "ALIGNMENT COMPLETED SUCCESSFULLY" | tee -a $LOGFILE
echo "Alignment files generated in: $OUTDIR" | tee -a $LOGFILE
echo "===================================" | tee -a $LOGFILE
