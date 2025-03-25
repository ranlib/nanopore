#
# Raven
#
Raven:
	womtool validate --inputs Raven.json Raven.wdl
	miniwdl check Raven.wdl

doc_Raven:
	wdl-aid Raven.wdl -o Raven.md
	womtool graph Raven.wdl > Raven.dot
	dot -Tpdf -o Raven.pdf Raven.dot
	dot -Tjpeg -o Raven.jpeg Raven.dot
	rm Raven.dot

run_Raven:
	miniwdl run --debug --dir test-Raven --cfg ../../../miniwdl_production.cfg --input Raven.json Raven.wdl

#
# Flye
#
Flye:
	womtool validate --inputs Flye.json Flye.wdl
	miniwdl check Flye.wdl

doc_Flye:
	wdl-aid Flye.wdl -o Flye.md
	womtool graph Flye.wdl > Flye.dot
	dot -Tpdf -o Flye.pdf Flye.dot
	dot -Tjpeg -o Flye.jpeg Flye.dot
	rm Flye.dot

run_Flye:
	miniwdl run --debug --dir test-Flye --cfg ../../../miniwdl_production.cfg --input Flye.json Flye.wdl

#
# Canu
#
Canu:
	womtool validate --inputs Canu.json Canu.wdl
	miniwdl check Canu.wdl

doc_Canu:
	wdl-aid Canu.wdl -o Canu.md
	womtool graph Canu.wdl > Canu.dot
	dot -Tpdf -o Canu.pdf Canu.dot
	dot -Tjpeg -o Canu.jpeg Canu.dot
	rm Canu.dot

run_Canu:
	miniwdl run --debug --dir test-Canu --cfg ../../../miniwdl_production.cfg --input Canu.json Canu.wdl

#
# Hifiasm
#
Hifiasm:
	womtool validate --inputs Hifiasm.json Hifiasm.wdl
	miniwdl check Hifiasm.wdl

doc_Hifiasm:
	wdl-aid Hifiasm.wdl -o Hifiasm.md
	womtool graph Hifiasm.wdl > Hifiasm.dot
	dot -Tpdf -o Hifiasm.pdf Hifiasm.dot
	dot -Tjpeg -o Hifiasm.jpeg Hifiasm.dot
	rm Hifiasm.dot

run_Hifiasm:
	miniwdl run --debug --dir test-Hifiasm --cfg ../../../miniwdl_production.cfg --input Hifiasm.json Hifiasm.wdl

