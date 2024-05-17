version 1.0

import "./task_minimap2.wdl" as minimap2
import "./task_sortSam.wdl" as sort_sam

workflow wf_minimap2 {
  input {
    File reference
    File read1
    File read2
    String outputPrefix
    String samplename
    Int threads = 1
  }

  call minimap2.Indexing {
    input:
    referenceFile = reference,
    outputPrefix = outputPrefix,
    cores = threads
  }
  
  call minimap2.Mapping {
    input:
    referenceFile = reference,
    queryFile1 = read1,
    queryFile2 = read2,
    outputPrefix = samplename,
    presetOption = "sr",
    addMDTagToSam = true,
    outputSam = true,
    cores = threads
  }

  call sort_sam.task_sortSam {
    input:
    samplename = samplename,
    insam = Mapping.alignmentFile
  }

  output {
    File sam = Mapping.alignmentFile
    File mmi = Indexing.indexFile
    File bam = task_sortSam.outbam
    File bai = task_sortSam.outbamidx
  }
}
