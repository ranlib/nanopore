#!/bin/bash
shopt -s expand_aliases
alias snpEff="java -jar $HOME/Software/snpEff/snpEff.jar"


cp $HOME/Software/snpEff/snpEff.config .

ORG=NZ_CP014204.2
mkdir -p data/$ORG
cp ../data/C_baratii/reference/$ORG.gb data/$ORG/genes.gbk
echo "${ORG}.genome: ${ORG}" >> snpEff.config
snpEff build -c snpEff.config -genbank -v $ORG

ORG=CP006905.1
ORGFILE=../data/C_baratii/reference/GCA_000789395.1_ASM78939v1_genomic.gb
mkdir -p data/$ORG
cp $ORGFILE data/$ORG/genes.gbk
echo "${ORG}.genome: ${ORG}" >> snpEff.config
snpEff build -c snpEff.config -genbank -v $ORG

zip -r snpEff.zip data

exit 0
