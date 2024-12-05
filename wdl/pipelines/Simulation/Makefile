docs_dir = $(subst wdl,docs,$(PWD))

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
# read analysis
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
