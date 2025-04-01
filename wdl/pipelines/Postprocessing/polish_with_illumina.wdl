version 1.0

import "../../tasks/Alignment/wf_minimap2.wdl" as Minimap2
import "../../tasks/Postprocessing/Pilon.wdl" as Pilon

workflow polish_with_illumina {
  
  meta {
    description: "Perform polishing of long-read assembly with illumina reads using Pilon"
  }
  
  parameter_meta {
    reads: { description: "Array of input illumina fastq files." }
    ref_fasta: { description: "Fasta file of sequence to be polished."}
    RG: { description: "Read group for minimap2 mapper."}
    sample_name: { description: "name of the sample"}
    prefix: { description: "prefix for output files"}
    map_preset: { description: "mapping preset for minimap2"}
    library: { description: "library prep kit used for illumina sequencing"}
    tags_to_preserve: { description: "tags to preserve in the output bam file"}
  }
  
  input {
    Array[File] reads
    File ref_fasta
    String samplename
    Int threads = 64
  }

  call Minimap2.wf_minimap2 {
    input:
    reference = ref_fasta,
    read1 = reads[0],
    read2 = reads[1],
    samplename = samplename,
    threads = threads
  }
  
  call Pilon.Pilon {
    input:
    genome_fasta = ref_fasta,
    frags_bam = wf_minimap2.bam,
    frags_bai = wf_minimap2.bai 
  }

  
  output {
    File aligned_bam = wf_minimap2.bam
    File aligned_bai = wf_minimap2.bai
    File polished_fasta = Pilon.polished_fasta
    File vcf = Pilon.vcf
    File changes = Pilon.changes
  }
}

  
