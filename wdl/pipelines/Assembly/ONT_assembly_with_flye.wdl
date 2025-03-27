version 1.0
import "../../tasks/Utilities/Utils.wdl" as Utils
import "../../tasks/Assembly/Flye.wdl" as Flye
import "../../tasks/Preprocessing/Medaka.wdl" as Medaka
import "../../tasks/QC/Quast.wdl" as Quast
import "../../tasks/VariantCalling/CallAssemblyVariants.wdl" as AV

workflow ONT_assembly_with_flye {

  meta {
    description: "Perform single sample genome assembly on ONT reads and variant calling."
  }
  
  parameter_meta {
    fastqs: { description: "input fastq files for a sample" }
    reference: { description: "reference sequence"}
    medaka_model: { description: "Medaka polishing model name"}
    sample_name: { description: "name of sample"}
    prefix: { description: "prefix for output files"}
    n_rounds: { description: "number of medaka polishing rounds"}
  }
  
  input {
    Array[File]+ fastqs

    String read_type # One of: "--pacbio-raw", "--pacbio-corr", "--pacbio-hifi", "--nano-raw", "--nano-corr", "--nano-hq"
    Int threads = 1  # Number of threads
    Int iterations = 1  # Number of polishing iterations
    Int? min_overlap  # Minimum overlap between reads
    Int? asm_coverage  # Reduced coverage for initial disjointig assembly
    Boolean metagenome = false  # Metagenome mode
    Boolean keep_haplotypes = false  # Keep alternative haplotypes
    Float? read_error  # Read error rate adjustment

    String medaka_model = "r941_min_high_g360"
    Int n_rounds = 1

    File reference

    String sample_name
    String prefix
  }

  call Utils.ComputeGenomeLength { input: fasta = reference }

  call Utils.MergeFastqs { input: fastqs = fastqs }
  
  call Flye.Flye {
    input:
    reads = [ MergeFastqs.merged_fastq ],
    read_type = read_type,
    output_dir = prefix,
    genome_size = ceil(ComputeGenomeLength.length),
    threads = threads,
    iterations = iterations,
    min_overlap = min_overlap,
    asm_coverage = asm_coverage,
    metagenome = metagenome,
    keep_haplotypes = keep_haplotypes,
    read_error = read_error

  }
  
  call Medaka.MedakaPolish {
    input:
    basecalled_reads = MergeFastqs.merged_fastq,
    draft_assembly = Flye.assembly_files[0],
    model = medaka_model,
    prefix = basename(Flye.assembly_files[0], ".fasta") + ".consensus",
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
    sample_name = sample_name,
    prefix = prefix + ".flye"
  }

  call Quast.SummarizeQuastReport as summaryQ {input: quast_report_txt = Quast.report_txt}
  Map[String, String] q_metrics = read_map(summaryQ.quast_metrics[0])

  output {
    # Flye
    Array[File] assembly_files = Flye.assembly_files
    
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
