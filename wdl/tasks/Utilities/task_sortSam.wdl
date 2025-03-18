version 1.0

task task_sortSam {
  input {
    String samplename
    File insam
  }
  
  command <<<
    gatk SortSam \
    --INPUT ~{insam} \
    --OUTPUT ~{samplename}.sorted.bam \
    --SORT_ORDER coordinate \
    --CREATE_INDEX true
  >>>

  output {
    File outbam = "${samplename}.sorted.bam"
    File outbamidx = "${samplename}.sorted.bai"
  }

  runtime {
    docker: "broadinstitute/gatk:4.6.1.0"
    memory: "16GB"
  }
}
