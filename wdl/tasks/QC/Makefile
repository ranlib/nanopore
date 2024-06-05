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

#
# Chopper
#
Chopper:
	java -jar ~/Software/womtool-86.jar validate --inputs Chopper.json Chopper.wdl
	miniwdl check Chopper.wdl

doc_Chopper:
	wdl-aid Chopper.wdl -o Chopper.md
	java -jar ~/Software/womtool-86.jar graph Chopper.wdl > Chopper.dot
	dot -Tpdf -o Chopper.pdf Chopper.dot
	dot -Tjpeg -o Chopper.jpeg Chopper.dot
	rm Chopper.dot

run_Chopper:
	time miniwdl run --debug --dir test-Chopper --cfg ../../../miniwdl_production.cfg --input Chopper.json Chopper.wdl

