docs_dir = $(subst wdl,docs,$(PWD))

#
# Flye
#
ONT_assembly_with_flye:
	java -jar ~/Software/womtool-86.jar validate --inputs ONT_assembly_with_flye.json ONT_assembly_with_flye.wdl
	miniwdl check ONT_assembly_with_flye.wdl

doc_ONT_assembly_with_flye:
	wdl-aid ONT_assembly_with_flye.wdl -o ONT_assembly_with_flye.md
	java -jar ~/Software/womtool-86.jar graph ONT_assembly_with_flye.wdl > ONT_assembly_with_flye.dot
	dot -Tpdf -o ONT_assembly_with_flye.pdf ONT_assembly_with_flye.dot
	dot -Tjpeg -o ONT_assembly_with_flye.jpeg ONT_assembly_with_flye.dot
	rm ONT_assembly_with_flye.dot
	echo $(docs_dir)
	mkdir -p $(docs_dir)
	cp *.md *.jpeg *.pdf $(docs_dir)

run_ONT_assembly_with_flye:
	time miniwdl run --debug --dir test-ONT_assembly_with_flye --cfg ../../../miniwdl_production.cfg --input ONT_assembly_with_flye.json ONT_assembly_with_flye.wdl

run_ONT_assembly_with_flye_dieter:
	time miniwdl run --debug --dir test-ONT_assembly_with_flye --cfg ../../../miniwdl_production.cfg --input ONT_assembly_with_flye_dieter.json ONT_assembly_with_flye.wdl
#
# Canu
#
ONT_assembly_with_canu:
	java -jar ~/Software/womtool-86.jar validate --inputs ONT_assembly_with_canu.json ONT_assembly_with_canu.wdl
	miniwdl check ONT_assembly_with_canu.wdl

doc_ONT_assembly_with_canu:
	wdl-aid ONT_assembly_with_canu.wdl -o ONT_assembly_with_canu.md
	java -jar ~/Software/womtool-86.jar graph ONT_assembly_with_canu.wdl > ONT_assembly_with_canu.dot
	dot -Tpdf -o ONT_assembly_with_canu.pdf ONT_assembly_with_canu.dot
	dot -Tjpeg -o ONT_assembly_with_canu.jpeg ONT_assembly_with_canu.dot
	rm ONT_assembly_with_canu.dot
	echo $(docs_dir)
	mkdir -p $(docs_dir)
	cp *.md *.jpeg *.pdf $(docs_dir)

run_ONT_assembly_with_canu:
	time miniwdl run --debug --dir test-ONT_assembly_with_canu --cfg ../../../miniwdl_production.cfg --input ONT_assembly_with_canu.json ONT_assembly_with_canu.wdl

#
# Raven
#
ONT_assembly_with_raven:
	java -jar ~/Software/womtool-86.jar validate --inputs ONT_assembly_with_raven.json ONT_assembly_with_raven.wdl
	miniwdl check ONT_assembly_with_raven.wdl

doc_ONT_assembly_with_raven:
	wdl-aid ONT_assembly_with_raven.wdl -o ONT_assembly_with_raven.md
	java -jar ~/Software/womtool-86.jar graph ONT_assembly_with_raven.wdl > ONT_assembly_with_raven.dot
	dot -Tpdf -o ONT_assembly_with_raven.pdf ONT_assembly_with_raven.dot
	dot -Tjpeg -o ONT_assembly_with_raven.jpeg ONT_assembly_with_raven.dot
	rm ONT_assembly_with_raven.dot
	echo $(docs_dir)
	mkdir -p $(docs_dir)
	cp *.md *.jpeg *.pdf $(docs_dir)

#2.81user 0.35system 4:15.69elapsed 1%CPU (0avgtext+0avgdata 56980maxresident)k
#0inputs+3400outputs (0major+20077minor)pagefaults 0swaps
run_ONT_assembly_with_raven:
	time miniwdl run --debug --dir test-ONT_assembly_with_raven --cfg ../../../miniwdl_production.cfg --input ONT_assembly_with_raven.json ONT_assembly_with_raven.wdl

#
# Hifiasm
#
ONT_assembly_with_hifiasm:
	java -jar ~/Software/womtool-86.jar validate --inputs ONT_assembly_with_hifiasm.json ONT_assembly_with_hifiasm.wdl
	miniwdl check ONT_assembly_with_hifiasm.wdl

doc_ONT_assembly_with_hifiasm:
	wdl-aid ONT_assembly_with_hifiasm.wdl -o ONT_assembly_with_hifiasm.md
	java -jar ~/Software/womtool-86.jar graph ONT_assembly_with_hifiasm.wdl > ONT_assembly_with_hifiasm.dot
	dot -Tpdf -o ONT_assembly_with_hifiasm.pdf ONT_assembly_with_hifiasm.dot
	dot -Tjpeg -o ONT_assembly_with_hifiasm.jpeg ONT_assembly_with_hifiasm.dot
	rm ONT_assembly_with_hifiasm.dot
	echo $(docs_dir)
	mkdir -p $(docs_dir)
	cp *.md *.jpeg *.pdf $(docs_dir)

#2.81user 0.35system 4:15.69elapsed 1%CPU (0avgtext+0avgdata 56980maxresident)k
#0inputs+3400outputs (0major+20077minor)pagefaults 0swaps
run_ONT_assembly_with_hifiasm:
	time miniwdl run --debug --dir test-ONT_assembly_with_hifiasm --cfg ../../../miniwdl_production.cfg --input ONT_assembly_with_hifiasm.json ONT_assembly_with_hifiasm.wdl

