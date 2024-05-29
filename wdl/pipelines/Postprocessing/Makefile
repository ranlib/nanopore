polish_with_illumina:
	java -jar ~/Software/womtool-86.jar validate --inputs polish_with_illumina.json polish_with_illumina.wdl
	miniwdl check polish_with_illumina.wdl

doc_polish_with_illumina:
	wdl-aid polish_with_illumina.wdl -o polish_with_illumina.md
	java -jar ~/Software/womtool-86.jar graph polish_with_illumina.wdl > polish_with_illumina.dot
	dot -Tpdf -o polish_with_illumina.pdf polish_with_illumina.dot
	dot -Tjpeg -o polish_with_illumina.jpeg polish_with_illumina.dot
	rm polish_with_illumina.dot

run_polish_with_illumina:
	time miniwdl run --debug --dir test-polish_with_illumina --cfg ../../../miniwdl_production.cfg --input polish_with_illumina.json polish_with_illumina.wdl

