ont_guppy_cpu:
	java -jar ~/Software/womtool-86.jar validate --inputs ont_guppy_cpu.json ont_guppy_cpu.wdl
	miniwdl check ont_guppy_cpu.wdl

doc_ont_guppy_cpu:
	wdl-aid ont_guppy_cpu.wdl -o ont_guppy_cpu.md
	java -jar ~/Software/womtool-86.jar graph ont_guppy_cpu.wdl > ont_guppy_cpu.dot
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
