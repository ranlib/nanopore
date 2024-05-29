Alignment:
	java -jar ~/Software/womtool-86.jar validate --inputs Alignment.json Alignment.wdl
	miniwdl check Alignment.wdl

doc_Alignment:
	wdl-aid Alignment.wdl -o Alignment.md
	java -jar ~/Software/womtool-86.jar graph Alignment.wdl > Alignment.dot
	dot -Tpdf -o Alignment.pdf Alignment.dot
	dot -Tjpeg -o Alignment.jpeg Alignment.dot
	rm Alignment.dot

run_Alignment:
	miniwdl run --debug --dir test-Alignment --cfg ../../../miniwdl_production.cfg --input Alignment.json Alignment.wdl

