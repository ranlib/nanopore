version 1.0

import "../../tasks/Alignment/AlignReads.wdl" as Align
import "../../tasks/Alignment/wf_minimap2.wdl" as Minimap2
import "../../tasks/Postprocessing/Pilon.wdl" as Pilon

workflow polish_with_illumina {
  
  meta {
    description: "Perform polishing of long-read assembly with illumina reads."
  }
  
  parameter_meta {
    fastq: { description: "input fastq file" }
    ref_map_file: { description: "reference sequence"}
    medaka_model: { description: "Medaka polishing model name"}
    participant_name: { description: "name of the participant from whom these samples were obtained"}
    prefix: { description: "prefix for output files"}
    n_rounds: { description: "number of medaka polishing rounds"}
  }
  
  input {
    Array[File] reads
    File ref_fasta
    String RG
    String map_preset
    String? library
    Array[String] tags_to_preserve = []
    String prefix = "out"
    RuntimeAttr? runtime_attr_override
  }

  # call Align.Minimap2 {
  #   input:
  #   reads = reads,
  #   ref_fasta = ref_fasta,
  #   RG = RG,
  #   map_preset = map_preset,
  #   library = library,
  #   tags_to_preserve = tags_to_preserve,
  #   prefix = prefix,
  #   runtime_attr_override = runtime_attr_override
  # }

  call Minimap2.wf_minimap2 {
    input:
    reference = ref_fasta,
    read1 = reads[0],
    read2 = reads[1],
    outputPrefix = prefix,
    samplename = "out",
    threads = 64
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

  
