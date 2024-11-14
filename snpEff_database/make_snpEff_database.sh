#!/bin/bash
shopt -s expand_aliases
alias snpEff="java -jar $HOME/Software/snpEff/snpEff.jar"

ORG=NZ_CP014204.2

mkdir -p data/$ORG
cp ../data/$ORG.gb data/$ORG/genes.gbk
cp $HOME/Software/snpEff/snpEff.config .
echo "${ORG}.genome: ${ORG}" >> snpEff.config
snpEff build -c snpEff.config -genbank -v $ORG
zip -r snpEff.zip data

exit 0
