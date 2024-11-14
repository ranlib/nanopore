SHELL=/bin/bash

DeepVariant:
	java -jar ~/Software/womtool-86.jar validate --inputs DeepVariant.json DeepVariant.wdl
	miniwdl check DeepVariant.wdl

doc_DeepVariant:
	wdl-aid DeepVariant.wdl -o DeepVariant.md
	java -jar ~/Software/womtool-86.jar graph DeepVariant.wdl > DeepVariant.dot
	dot -Tpdf -o DeepVariant.pdf DeepVariant.dot
	dot -Tjpeg -o DeepVariant.jpeg DeepVariant.dot
	rm DeepVariant.dot

run_DeepVariant:
	time miniwdl run --debug --dir test-DeepVariant --cfg ../../../miniwdl_production.cfg --input DeepVariant.json DeepVariant.wdl
