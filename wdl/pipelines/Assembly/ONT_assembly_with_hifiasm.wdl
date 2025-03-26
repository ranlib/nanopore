version 1.0
import "../../tasks/Utilities/Utils.wdl" as Utils
import "../../tasks/Assembly/Hifiasm.wdl" as Assembler
import "../../tasks/Preprocessing/Medaka.wdl" as Medaka
import "../../tasks/QC/Quast.wdl" as AssemblyQC
import "../../tasks/VariantCalling/CallAssemblyVariants.wdl" as AV

workflow ONT_assembly_with_hifiasm {

  meta {
    description: "Perform single sample genome assembly on ONT reads and variant calling."
  }
  
  parameter_meta {
    reads: { description: "Input fastq files for a sample." }
    output_prefix: { description: "Prefix for output files from hifiasm." }
    threads: { description: "Number of threads for hifiasm."}
    use_ont: { description: "Switch to turn on if input fastq files are Oxford Nanopore data."}
    
    medaka_model: { description: "Medaka polishing model name"}
    n_rounds: { description: "number of medaka polishing rounds"}

    reference: { description: "reference sequence"}

    sample_name: { description: "name of sample"}
    prefix: { description: "prefix for output files"}
  }
  
  input {
    # hifiasm
    Array[File]+ reads
    String output_prefix = "hifiasm.asm"
    Int threads = 1  
    Boolean use_ont = true

    # medaka
    String medaka_model = "r941_min_high_g360"
    Int n_rounds = 1

    # Quast
    File reference

    # assembly variants
    String sample_name
    String prefix
  }

  call Utils.MergeFastqs { input: fastqs = reads }
  
  call Assembler.Hifiasm {
    input:
    reads = reads,
    output_prefix = output_prefix,
    threads = threads,
    use_ont = use_ont
  }

  call Assembler.gfa_to_fa {
    input:
    gfa = Hifiasm.assembly_files[0]
  }
  
  call Medaka.MedakaPolish {
    input:
    basecalled_reads = MergeFastqs.merged_fastq,
    draft_assembly = gfa_to_fa.fa,
    model = medaka_model,
    prefix = basename(gfa_to_fa.fa, ".fa") + ".consensus",
    n_rounds = n_rounds
  }
  
  call AssemblyQC.Quast {
    input:
    ref = reference,
    assemblies = [ MedakaPolish.polished_assembly ]
  }

  call AV.CallAssemblyVariants {
    input:
    asm_fasta = MedakaPolish.polished_assembly,
    ref_fasta = reference,
    sample_name = sample_name,
    prefix = prefix + ".hifiasm"
  }

  call AssemblyQC.SummarizeQuastReport as summaryQ {input: quast_report_txt = Quast.report_txt}
  Map[String, String] q_metrics = read_map(summaryQ.quast_metrics[0])

  output {
    # Hifiasm
    Array[File] assembly_files = Hifiasm.assembly_files
    
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
