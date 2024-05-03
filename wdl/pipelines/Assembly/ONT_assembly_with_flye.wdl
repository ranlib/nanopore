version 1.0

import "../../tasks/Assembly/Flye.wdl" as Flye
import "../../tasks/Preprocessing/Medaka.wdl" as Medaka
import "../../tasks/QC/Quast.wdl" as Quast
import "../../tasks/VariantCalling/CallAssemblyVariants.wdl" as AV

workflow ONT_assembly_with_flye {
  meta {
    description: "Perform single sample genome assembly on ONT reads and variant calling."
  }
  parameter_meta {
    fastq: { description: "input fastq file" }
    ref_map_file: { description: "reference sequence"}
    medaka_model: { description: "Medaka polishing model name"}
    participant_name: { description: "name of the participant from whom these samples were obtained"}
    prefix: { description: "prefix for output files"}
    out_root_dir: { description: "directory to store the reads, variants, and metrics files"}
    n_rounds: { description: "number of medaka polishing rounds"}
  }
  
  input {
    File fastq
    String medaka_model = "r941_min_high_g360"
    String prefix
    File ref_map_file
    String participant_name
    String out_root_dir = "pipeline"
    Int genome_size = 3900000
    Int n_rounds = 1
  }
  
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
    n_rounds = n_rounds
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
    prefix = prefix + ".flye"
  }

  call Quast.SummarizeQuastReport as summaryQ {input: quast_report_txt = Quast.report_txt}
  Map[String, String] q_metrics = read_map(summaryQ.quast_metrics[0])

  output {
    # Flye
    File assembly = Flye.fa
    File gassembly = Flye.gfa

    # Medaka polishing
    File polished_assembly = MedakaPolish.polished_assembly

    # Assembly variants
    File paf = CallAssemblyVariants.paf
    File paftools_vcf = CallAssemblyVariants.paftools_vcf

    # Quast
    File report_txt = Quast.report_txt
    File report_html = Quast.report_html
    Array[File] report_in_various_formats = Quast.report_in_various_formats
    Array[File] plots = Quast.plots
    File? contigs_reports = Quast.contigs_reports
    Map[String, String] quast_summary = q_metrics
  }
}
