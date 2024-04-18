version 1.0

import "../../tasks/Assembly/Flye.wdl" as Flye

workflow ONT_assemble_with_flye {
    meta {
        description: "Perform single sample genome assembly on ONT reads from one or more flow cells. The workflow merges multiple samples into a single BAM prior to genome assembly and variant calling."
    }
    parameter_meta {
        fastq:       "GCS path to unaligned CCS BAM files"
        ref_map_file:        "table indicating reference sequence and auxillary file locations"
        medaka_model:        "Medaka polishing model name"
        participant_name:    "name of the participant from whom these samples were obtained"
        prefix:              "prefix for output files"
        out_root_dir:    "GCS bucket to store the reads, variants, and metrics files"
    }

    input {
      File fastq
      String prefix
      String out_root_dir = "pipeline"
      Int genome_size = 3900000
    }
    
    String outdir = out_root_dir + "/ONTAssembleWithFlye/~{prefix}"
    
    call Flye.Flye {
      input:
      reads = fastq,
      genome_size = genome_size,
      prefix = prefix,
    }
    
    output {
      File assembly = Flye.fa
      File gassembly = Flye.gfa
    }
}
