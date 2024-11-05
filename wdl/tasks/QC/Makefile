#
# NanoPack
#
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

#
# FastQC_fastq
#
FastQC_fastq:
	java -jar ~/Software/womtool-86.jar validate --inputs FastQC_fastq.json FastQC_fastq.wdl
	miniwdl check FastQC_fastq.wdl

doc_FastQC_fastq:
	wdl-aid FastQC_fastq.wdl -o FastQC_fastq.md
	java -jar ~/Software/womtool-86.jar graph FastQC_fastq.wdl > FastQC_fastq.dot
	dot -Tpdf -o FastQC_fastq.pdf FastQC_fastq.dot
	dot -Tjpeg -o FastQC_fastq.jpeg FastQC_fastq.dot
	rm FastQC_fastq.dot

run_FastQC_fastq:
	time miniwdl run --debug --dir test-FastQC_fastq --cfg ../../../miniwdl_production.cfg --input FastQC_fastq.json FastQC_fastq.wdl

#
# SampleLevelAlignedMetrics
#
SampleLevelAlignedMetrics:
	java -jar ~/Software/womtool-86.jar validate --inputs SampleLevelAlignedMetrics.json SampleLevelAlignedMetrics.wdl
	miniwdl check SampleLevelAlignedMetrics.wdl

doc_SampleLevelAlignedMetrics:
	wdl-aid SampleLevelAlignedMetrics.wdl -o SampleLevelAlignedMetrics.md
	java -jar ~/Software/womtool-86.jar graph SampleLevelAlignedMetrics.wdl > SampleLevelAlignedMetrics.dot
	dot -Tpdf -o SampleLevelAlignedMetrics.pdf SampleLevelAlignedMetrics.dot
	dot -Tjpeg -o SampleLevelAlignedMetrics.jpeg SampleLevelAlignedMetrics.dot
	rm SampleLevelAlignedMetrics.dot

run_SampleLevelAlignedMetrics:
	time miniwdl run --debug --dir test-SampleLevelAlignedMetrics --cfg ../../../miniwdl_production.cfg --input SampleLevelAlignedMetrics.json SampleLevelAlignedMetrics.wdl

#
# bcftools_stats
#
bcftools_stats:
	java -jar ~/Software/womtool-86.jar validate --inputs wf_bcftools_stats.json wf_bcftools_stats.wdl
	miniwdl check wf_bcftools_stats.wdl

doc_bcftools_stats:
	wdl-aid wf_bcftools_stats.wdl -o wf_bcftools_stats.md
	java -jar ~/Software/womtool-86.jar graph wf_bcftools_stats.wdl > wf_bcftools_stats.dot
	dot -Tpdf -o wf_bcftools_stats.pdf wf_bcftools_stats.dot
	dot -Tjpeg -o wf_bcftools_stats.jpeg wf_bcftools_stats.dot
	rm wf_bcftools_stats.dot

run_bcftools_stats:
	time miniwdl run --debug --dir test-bcftools_stats --cfg ../../../miniwdl_production.cfg --input wf_bcftools_stats.json wf_bcftools_stats.wdl

