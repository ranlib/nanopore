NanoPack:
	java -jar ~/Software/womtool-86.jar validate --inputs NanoPack.json NanoPack.wdl
	miniwdl check NanoPack.wdl

doc_NanoPack:
	wdl-aid NanoPack.wdl -o NanoPack.md
	java -jar ~/Software/womtool-86.jar graph NanoPack.wdl > NanoPack.dot
	dot -Tpdf -o NanoPack.pdf NanoPack.dot
	dot -Tjpeg -o NanoPack.jpeg NanoPack.dot
	rm NanoPack.dot

run_NanoPack:
	time miniwdl run --debug --dir test-NanoPack --cfg ../../../miniwdl_production.cfg --input NanoPack.json NanoPack.wdl

