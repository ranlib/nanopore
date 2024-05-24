version 1.0
import "../../tasks/Utilities/Utils.wdl" as Utils
import "../../tasks/Assembly/Raven.wdl" as Raven
import "../../tasks/Preprocessing/Medaka.wdl" as Medaka
import "../../tasks/QC/Quast.wdl" as Quast
import "../../tasks/VariantCalling/CallAssemblyVariants.wdl" as AV

workflow ONT_assembly_with_raven {

  meta {
    description: "Perform single sample genome assembly on ONT reads and variant calling."
  }
  
  parameter_meta {
    fastqs: { description: "input fastq files for a sample" }
    reference: { description: "reference sequence"}
    medaka_model: { description: "Medaka polishing model name"}
    participant_name: { description: "name of the participant from whom these samples were obtained"}
    prefix: { description: "prefix for output files"}
    n_rounds: { description: "number of medaka polishing rounds"}
  }
  
  input {
    Array[File]+ fastqs
    File reference
    String medaka_model = "r941_min_high_g360"
    String participant_name
    String prefix
    Int n_rounds = 1
  }

  call Utils.ComputeGenomeLength { input: fasta = reference }

  call Utils.MergeFastqs { input: fastqs = fastqs }
  
  call Raven.Raven {
    input:
    sequences = MergeFastqs.merged_fastq
  }
  
  call Medaka.MedakaPolish {
    input:
    basecalled_reads = MergeFastqs.merged_fastq,
    draft_assembly = Raven.output_fasta,
    model = medaka_model,
    prefix = basename(Raven.output_fasta, ".fasta") + ".consensus",
    n_rounds = n_rounds
  }
  
  call Quast.Quast {
    input:
    ref = reference,
    assemblies = [ MedakaPolish.polished_assembly ]
  }

  call AV.CallAssemblyVariants {
    input:
    asm_fasta = MedakaPolish.polished_assembly,
    ref_fasta = reference,
    participant_name = participant_name,
    prefix = prefix + ".raven"
  }

  call Quast.SummarizeQuastReport as summaryQ {input: quast_report_txt = Quast.report_txt}
  Map[String, String] q_metrics = read_map(summaryQ.quast_metrics[0])

  output {
    # Raven
    File assembly = Raven.output_fasta
    File? gassembly = Raven.graphical_fragment_assembly_file
    
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
