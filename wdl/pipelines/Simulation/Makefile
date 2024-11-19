docs_dir = $(subst wdl,docs,$(PWD))

Simulation:
	java -jar ~/Software/womtool-86.jar validate --inputs Simulation.json Simulation.wdl
	miniwdl check Simulation.wdl

doc_Simulation:
	wdl-aid Simulation.wdl -o Simulation.md
	java -jar ~/Software/womtool-86.jar graph Simulation.wdl > Simulation.dot
	dot -Tpdf -o Simulation.pdf Simulation.dot
	dot -Tjpeg -o Simulation.jpeg Simulation.dot
	rm Simulation.dot
	echo $(docs_dir)
	mkdir -p $(docs_dir)
	mv *.md *.jpeg *.pdf $(docs_dir)

# about 8 min per sample
run_Simulation:
	time miniwdl run --debug --dir test-Simulation --cfg ../../../miniwdl_production.cfg --input Simulation.json Simulation.wdl

run_Simulation_cromwell:
	time java -jar ~/Software/cromwell-86.jar run Simulation.wdl -i Simulation.json
