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

#2.81user 0.35system 4:15.69elapsed 1%CPU (0avgtext+0avgdata 56980maxresident)k
#0inputs+3400outputs (0major+20077minor)pagefaults 0swaps
run_ONT_assembly_with_raven:
	time miniwdl run --debug --dir test-ONT_assembly_with_raven --cfg ../../../miniwdl_production.cfg --input ONT_assembly_with_raven.json ONT_assembly_with_raven.wdl

