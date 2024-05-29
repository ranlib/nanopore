version 1.0

import "../../tasks/Alignment/AlignReads.wdl" as Align

workflow Alignment {
  
  meta {
    description: "Perform alignment of reads to reference via minimap2."
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

  call Align.Minimap2 {
    input:
    reads = reads,
    ref_fasta = ref_fasta,
    RG = RG,
    map_preset = map_preset,
    library = library,
    tags_to_preserve = tags_to_preserve,
    prefix = prefix,
    runtime_attr_override = runtime_attr_override
  }
  
  output {
    File aligned_bam = Minimap2.aligned_bam
    File aligned_bai = Minimap2.aligned_bai
  }

}

  
