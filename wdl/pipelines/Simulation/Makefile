docs_dir = $(subst wdl,docs,$(PWD))

#
# generate mutations
#
MutationSimulator:
	java -jar ~/Software/womtool-86.jar validate --inputs MutationSimulator.json MutationSimulator.wdl
	miniwdl check MutationSimulator.wdl

doc_MutationSimulator:
	wdl-aid MutationSimulator.wdl -o MutationSimulator.md
	java -jar ~/Software/womtool-86.jar graph MutationSimulator.wdl > MutationSimulator.dot
	dot -Tpdf -o MutationSimulator.pdf MutationSimulator.dot
	dot -Tjpeg -o MutationSimulator.jpeg MutationSimulator.dot
	rm MutationSimulator.dot
	echo $(docs_dir)
	mkdir -p $(docs_dir)
	mv *.md *.jpeg *.pdf $(docs_dir)

run_MutationSimulator:
	time miniwdl run --debug --dir test-MutationSimulator --cfg ../../../miniwdl_production.cfg --input MutationSimulator.json MutationSimulator.wdl

run_MutationSimulator_cromwell:
	time java -jar ~/Software/cromwell-86.jar run MutationSimulator.wdl -i MutationSimulator.json


#
# fastq simulation
#
GenomeSimulator:
	java -jar ~/Software/womtool-86.jar validate --inputs GenomeSimulator.json GenomeSimulator.wdl
	miniwdl check GenomeSimulator.wdl

doc_GenomeSimulator:
	wdl-aid GenomeSimulator.wdl -o GenomeSimulator.md
	java -jar ~/Software/womtool-86.jar graph GenomeSimulator.wdl > GenomeSimulator.dot
	dot -Tpdf -o GenomeSimulator.pdf GenomeSimulator.dot
	dot -Tjpeg -o GenomeSimulator.jpeg GenomeSimulator.dot
	rm GenomeSimulator.dot
	echo $(docs_dir)
	mkdir -p $(docs_dir)
	mv *.md *.jpeg *.pdf $(docs_dir)

# about 8 min per sample
run_GenomeSimulator:
	time miniwdl run --debug --dir test-GenomeSimulator --cfg ../../../miniwdl_production.cfg --input GenomeSimulator.json GenomeSimulator.wdl

run_GenomeSimulator_cromwell:
	time java -jar ~/Software/cromwell-86.jar run GenomeSimulator.wdl -i GenomeSimulator.json

#
# read analysis, make model for fastq simulation
#
ReadAnalysis:
	java -jar ~/Software/womtool-86.jar validate --inputs ReadAnalysis.json ReadAnalysis.wdl
	miniwdl check ReadAnalysis.wdl

doc_ReadAnalysis:
	wdl-aid ReadAnalysis.wdl -o ReadAnalysis.md
	java -jar ~/Software/womtool-86.jar graph ReadAnalysis.wdl > ReadAnalysis.dot
	dot -Tpdf -o ReadAnalysis.pdf ReadAnalysis.dot
	dot -Tjpeg -o ReadAnalysis.jpeg ReadAnalysis.dot
	rm ReadAnalysis.dot
	echo $(docs_dir)
	mkdir -p $(docs_dir)
	mv *.md *.jpeg *.pdf $(docs_dir)

# about 8 min per sample
run_ReadAnalysis:
	#time miniwdl run --debug --dir test-ReadAnalysis --cfg ../../../miniwdl_production.cfg --input ReadAnalysis.json ReadAnalysis.wdl
	time miniwdl run --debug --dir test-ReadAnalysis --cfg ../../../miniwdl_production.cfg --input ReadAnalysis_Cbaratii.json ReadAnalysis.wdl

run_ReadAnalysis_cromwell:
	time java -jar ~/Software/cromwell-86.jar run ReadAnalysis.wdl -i ReadAnalysis.json
