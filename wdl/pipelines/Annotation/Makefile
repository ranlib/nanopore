docs_dir = $(subst wdl,docs,$(PWD))

wf_snpEff:
	java -jar ~/Software/womtool-86.jar validate --inputs wf_snpEff.json wf_snpEff.wdl
	miniwdl check wf_snpEff.wdl

doc_wf_snpEff:
	wdl-aid wf_snpEff.wdl -o wf_snpEff.md
	java -jar ~/Software/womtool-86.jar graph wf_snpEff.wdl > wf_snpEff.dot
	dot -Tpdf -o wf_snpEff.pdf wf_snpEff.dot
	dot -Tjpeg -o wf_snpEff.jpeg wf_snpEff.dot
	rm wf_snpEff.dot
	echo $(docs_dir)
	mkdir -p $(docs_dir)
	mv *.md *.jpeg *.pdf $(docs_dir)

# about 8 min per sample
run_wf_snpEff:
	time miniwdl run --debug --dir test-wf_snpEff --cfg ../../../miniwdl_production.cfg --input wf_snpEff.json wf_snpEff.wdl

run_wf_snpEff_cromwell:
	time java -jar ~/Software/cromwell-86.jar run wf_snpEff.wdl -i wf_snpEff.json
