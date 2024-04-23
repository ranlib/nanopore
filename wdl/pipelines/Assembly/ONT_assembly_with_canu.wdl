version 1.0

import "../../tasks/Assembly/Canu.wdl" as Canu
import "../../tasks/Preprocessing/Medaka.wdl" as Medaka
import "../../tasks/QC/Quast.wdl" as Quast
import "../../tasks/VariantCalling/CallAssemblyVariants.wdl" as AV

workflow ONTAssembleWithCanu {
    meta {
        description: "A workflow that performs single sample genome assembly on ONT reads from one or more flow cells. The workflow merges multiple samples into a single BAM prior to genome assembly and variant calling."
    }
    parameter_meta {
        fastq:       "path to unaligned CCS BAM files"

        ref_map_file:        "table indicating reference sequence and auxillary file locations"

        correct_error_rate:  "stringency for overlaps in Canu's correction step"
        trim_error_rate:     "stringency for overlaps in Canu's trim step"
        assemble_error_rate: "stringency for overlaps in Canu's assemble step"
        medaka_model:        "Medaka polishing model name"

        participant_name:    "name of the participant from whom these samples were obtained"
        prefix:              "prefix for output files"

        out_root_dir:    "directory to store the reads, variants, and metrics files"
    }

    input {
      String fastq
      
      File ref_map_file
      Int genome_size
      Float correct_error_rate = 0.15
      Float trim_error_rate = 0.15
      Float assemble_error_rate = 0.15
      String medaka_model = "r941_prom_high_g360"
      
      String participant_name
      String prefix
      
      String out_root_dir
    }

    String outdir = out_root_dir + "/ONTAssembleWithCanu/~{prefix}"

    call Canu.Canu {
        input:
            reads = fastq,
            prefix = prefix,
            genome_size = genome_size,
            correct_error_rate = correct_error_rate,
            trim_error_rate = trim_error_rate,
            assemble_error_rate = assemble_error_rate
    }

    call Medaka.MedakaPolish {
        input:
            basecalled_reads = fastq,
            draft_assembly = Canu.fa,
            model = medaka_model,
            prefix = basename(Canu.fa, ".fasta") + ".polished",
            n_rounds = 3
    }

    call Quast.Quast {
        input:
            ref = ref_map_file,
            assemblies = [ MedakaPolish.polished_assembly ]
    }

    call AV.CallAssemblyVariants {
        input:
            asm_fasta = MedakaPolish.polished_assembly,
            ref_fasta = ref_map_file,
            participant_name = participant_name,
            prefix = prefix + ".canu"
    }

    output {
        File asm_polished = Canu.fa
    }
}
