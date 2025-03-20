docs_dir = $(subst wdl,docs,$(PWD))

#
# ont_variant_calling
#
ont_variant_calling:
	womtool validate --inputs ont_variant_calling.json ont_variant_calling.wdl
	miniwdl check ont_variant_calling.wdl

doc_ont_variant_calling:
	wdl-aid ont_variant_calling.wdl -o ont_variant_calling.md
	womtool graph ont_variant_calling.wdl > ont_variant_calling.dot
	dot -Tpdf -o ont_variant_calling.pdf ont_variant_calling.dot
	dot -Tjpeg -o ont_variant_calling.jpeg ont_variant_calling.dot
	rm ont_variant_calling.dot
	echo $(docs_dir)
	mkdir -p $(docs_dir)
	mv *.md *.jpeg *.pdf $(docs_dir)

# about 8 min per sample
run_ont_variant_calling:
	miniwdl run --debug --dir test-ont_variant_calling --cfg ../../../miniwdl_production.cfg --input ont_variant_calling.json ont_variant_calling.wdl

run_ont_variant_calling_cromwell:
	cromwell run ont_variant_calling.wdl -i ont_variant_calling.json
#
# ont_alignment_and_variant_calling
#
ont_alignment_and_variant_calling:
	womtool validate --inputs ont_alignment_and_variant_calling.json ont_alignment_and_variant_calling.wdl
	miniwdl check ont_alignment_and_variant_calling.wdl

doc_ont_alignment_and_variant_calling:
	wdl-aid ont_alignment_and_variant_calling.wdl -o ont_alignment_and_variant_calling.md
	womtool graph ont_alignment_and_variant_calling.wdl > ont_alignment_and_variant_calling.dot
	dot -Tpdf -o ont_alignment_and_variant_calling.pdf ont_alignment_and_variant_calling.dot
	dot -Tjpeg -o ont_alignment_and_variant_calling.jpeg ont_alignment_and_variant_calling.dot
	rm ont_alignment_and_variant_calling.dot
	echo $(docs_dir)
	mkdir -p $(docs_dir)
	mv *.md *.jpeg *.pdf $(docs_dir)

# about 8 min per sample
run_ont_alignment_and_variant_calling:
	miniwdl run --debug --dir test-ont_alignment_and_variant_calling --cfg ../../../miniwdl_production.cfg --input ont_alignment_and_variant_calling.json ont_alignment_and_variant_calling.wdl

run_ont_alignment_and_variant_calling_cromwell:
	cromwell run ont_alignment_and_variant_calling.wdl -i ont_alignment_and_variant_calling.json
