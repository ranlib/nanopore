#!/bin/bash
shopt -s expand_aliases
alias snpEff="java -jar $HOME/Software/snpEff/snpEff.jar"

ORG=CP000253.1

mkdir -p data/$ORG
cp $HOME/Analysis/nanopore/data/S_aureus/reference/$ORG.gb data/$ORG/genes.gbk
cp $HOME/Software/snpEff/snpEff.config .
echo "${ORG}.genome: ${ORG}" >> snpEff.config
snpEff build -c snpEff.config -genbank -v $ORG
zip -r snpEff.zip data

exit 0
