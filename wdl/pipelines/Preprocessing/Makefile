#
# Guppy
#
ont_guppy_cpu:
	java -jar ~/Software/womtool-87.jar validate --inputs ont_guppy_cpu.json ont_guppy_cpu.wdl
	miniwdl check ont_guppy_cpu.wdl

doc_ont_guppy_cpu:
	wdl-aid ont_guppy_cpu.wdl -o ont_guppy_cpu.md
	java -jar ~/Software/womtool-87.jar graph ont_guppy_cpu.wdl > ont_guppy_cpu.dot
	dot -Tpdf -o ont_guppy_cpu.pdf ont_guppy_cpu.dot
	dot -Tjpeg -o ont_guppy_cpu.jpeg ont_guppy_cpu.dot
	rm ont_guppy_cpu.dot

# about 2000 sequences, takes a very long time: 1 hour 43 min
run_ont_guppy_cpu:
	time miniwdl run --debug --dir test-ont_guppy_cpu --cfg ../../../miniwdl_production.cfg --input ont_guppy_cpu.json ont_guppy_cpu.wdl

# take 26 sec
run_ont_guppy_cpu_10:
	time miniwdl run --debug --dir test-ont_guppy_cpu_10 --cfg ../../../miniwdl_production.cfg --input ont_guppy_cpu_10.json ont_guppy_cpu.wdl

# takes 5.56 min
run_ont_guppy_cpu_100:
	time miniwdl run --debug --dir test-ont_guppy_cpu_100 --cfg ../../../miniwdl_production.cfg --input ont_guppy_cpu_100.json ont_guppy_cpu.wdl

ont_guppy_cpu_dir:
	java -jar ~/Software/womtool-87.jar validate --inputs ont_guppy_cpu_dir.json ont_guppy_cpu_dir.wdl
	miniwdl check ont_guppy_cpu_dir.wdl

doc_ont_guppy_cpu_dir:
	wdl-aid ont_guppy_cpu_dir.wdl -o ont_guppy_cpu_dir.md
	java -jar ~/Software/womtool-87.jar graph ont_guppy_cpu_dir.wdl > ont_guppy_cpu_dir.dot
	dot -Tpdf -o ont_guppy_cpu_dir.pdf ont_guppy_cpu_dir.dot
	dot -Tjpeg -o ont_guppy_cpu_dir.jpeg ont_guppy_cpu_dir.dot
	rm ont_guppy_cpu_dir.dot

#218.83user 21.65system 11:00:06elapsed 0%CPU (0avgtext+0avgdata 55608maxresident)k
#8inputs+350512outputs (0major+327820minor)pagefaults 0swaps
run_ont_guppy_cpu_dir:
	time miniwdl run --debug --dir test-ont_guppy_cpu_dir --cfg ../../../miniwdl_production.cfg --input ont_guppy_cpu_dir.json ont_guppy_cpu_dir.wdl

#
# Dorado
#
ont_dorado:
	java -jar ~/Software/womtool-87.jar validate --inputs ont_dorado.json ont_dorado.wdl
	miniwdl check ont_dorado.wdl

#10.28user 1.59system 48:21.44elapsed 0%CPU (0avgtext+0avgdata 55940maxresident)k
#25816inputs+26056outputs (96major+31980minor)pagefaults 0swaps
run_ont_dorado:
	time miniwdl run --debug --dir test-ont_dorado --cfg ../../../miniwdl_production.cfg --input ont_dorado.json ont_dorado.wdl

