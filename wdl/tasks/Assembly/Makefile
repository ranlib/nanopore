Raven:
	java -jar ~/Software/womtool-86.jar validate --inputs Raven.json Raven.wdl
	miniwdl check Raven.wdl

doc_Raven:
	wdl-aid Raven.wdl -o Raven.md
	java -jar ~/Software/womtool-86.jar graph Raven.wdl > Raven.dot
	dot -Tpdf -o Raven.pdf Raven.dot
	dot -Tjpeg -o Raven.jpeg Raven.dot
	rm Raven.dot

run_Raven:
	miniwdl run --debug --dir test-Raven --cfg ../../../miniwdl_production.cfg --input Raven.json Raven.wdl

