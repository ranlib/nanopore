ont_variant_calling:
	java -jar ~/Software/womtool-86.jar validate --inputs ont_variant_calling.json ont_variant_calling.wdl
	miniwdl check ont_variant_calling.wdl

doc_ont_variant_calling:
	wdl-aid ont_variant_calling.wdl -o ont_variant_calling.md
	java -jar ~/Software/womtool-86.jar graph ont_variant_calling.wdl > ont_variant_calling.dot
	dot -Tpdf -o ont_variant_calling.pdf ont_variant_calling.dot
	dot -Tjpeg -o ont_variant_calling.jpeg ont_variant_calling.dot
	rm ont_variant_calling.dot

run_ont_variant_calling:
	time miniwdl run --debug --dir test-ont_variant_calling --cfg ../../../miniwdl_production.cfg --input ont_variant_calling.json ont_variant_calling.wdl

run_ont_variant_calling_cromwell:
	time java -jar ~/Software/cromwell-86.jar run ont_variant_calling.wdl -i ont_variant_calling.json
