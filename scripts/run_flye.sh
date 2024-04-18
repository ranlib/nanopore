#!/bin/bash

FASTQ=/home/dieterbest/Analysis/nanopore/data/SRR7530167_10percent.fastq.gz

DATA=/home/dieterbest/Analysis/nanopore/data

FILE=/data/SRR7530167_10percent.fastq.gz

time docker run --rm -v $DATA:/data -v $PWD:/mnt -w /mnt dbest/flye:v2.9.3 flye --nano-raw $FILE --out-dir temp

exit 0
