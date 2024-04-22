version 1.0

import "../../tasks/Assembly/Flye.wdl" as Flye
import "../../tasks/Preprocessing/Medaka.wdl" as Medaka
import "../../tasks/VariantCalling/CallAssemblyVariants.wdl" as AV

workflow ONT_assembly_with_flye {
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
      String medaka_model = "r941_prom_high_g360"
      String prefix
      File ref_map_file
      String participant_name
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

    call Medaka.MedakaPolish {
        input:
            basecalled_reads = fastq,
            draft_assembly = Flye.fa,
            model = medaka_model,
            prefix = basename(Flye.fa, ".fasta") + ".consensus",
            n_rounds = 3
    }

    # call Quast.Quast {
    #     input:
    #         ref = ref_map['fasta'],
    #         assemblies = [ MedakaPolish.polished_assembly ]
    # }

    call AV.CallAssemblyVariants {
        input:
            asm_fasta = MedakaPolish.polished_assembly,
            ref_fasta = ref_map_file,
            participant_name = participant_name,
            prefix = prefix + ".flye"
    }

    
    output {
      File assembly = Flye.fa
      File gassembly = Flye.gfa
      File polished_assembly = MedakaPolish.polished_assembly
      File paf = CallAssemblyVariants.paf
      File paftools_vcf = CallAssemblyVariants.paftools_vcf
    }
}
