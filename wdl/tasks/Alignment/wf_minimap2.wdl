version 1.0

import "./task_minimap2.wdl" as minimap2
import "../Utilities/task_sortSam.wdl" as sort_sam

workflow wf_minimap2 {
  input {
    File reference
    File read1
    File read2
    String samplename
    Int threads = 1
    String presetOption = "sr"
    Boolean outputSam = true
    Boolean addMDTagToSam = true
    Boolean secondaryAlignment = false
    Boolean softClippingForSupplementaryAlignments = true
    Boolean writeLongCigar = true
    Int? maxIntronLength
    Int? maxFragmentLength
    Int? retainMaxSecondaryAlignments
    Int? matchingScore
    Int? mismatchPenalty
    String? howToFindGTAG
    String dockerImage = "staphb/minimap2:2.25" 
  } 

  call minimap2.Indexing {
    input:
    referenceFile = reference,
    outputPrefix = samplename,
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
