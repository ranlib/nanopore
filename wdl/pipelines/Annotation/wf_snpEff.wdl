version 1.0

import "./task_snpEff.wdl" as snpEff

workflow wf_snpEff {
  input {
    File vcf
    File dataDir
    File config
    String genome
  }


  call snpEff.task_snpEff {
    input:
    vcf = vcf,
    genome = genome,
    config = config,
    dataDir = dataDir
  }

  output {
    File outputVcf = task_snpEff.outputVcf
    File snpEff_summary_csv = task_snpEff.snpEff_summary_csv 
    File snpEff_summary_html = task_snpEff.snpEff_summary_html
  }
}
