version 1.0

import "../../tasks/Utilities/Utils.wdl" as Utils
import "../../tasks/Assembly/Canu.wdl" as Canu
import "../../tasks/Preprocessing/Medaka.wdl" as Medaka
import "../../tasks/QC/Quast.wdl" as Quast
import "../../tasks/VariantCalling/CallAssemblyVariants.wdl" as AV

workflow ONT_assembly_with_canu {

  meta {
    description: "perform single sample genome assembly on ONT reads using the canu assembler."
  }
  
  parameter_meta {
    fastqs:              "input fastq files for a sample"
    reference:           "input genome reference"
    correct_error_rate:  "stringency for overlaps in Canu's correction step"
    trim_error_rate:     "stringency for overlaps in Canu's trim step"
    assemble_error_rate: "stringency for overlaps in Canu's assemble step"
    medaka_model:        "Medaka polishing model name"
    sample_name:         "name of sample"
    prefix:              "prefix for output files"
  }
  
  input {
    Array[File]+ fastqs
    File reference
    Float correct_error_rate = 0.15
    Float trim_error_rate = 0.15
    Float assemble_error_rate = 0.15
    String medaka_model = "r941_min_high_g360"
    String sample_name
    String prefix
  }
  
  call Utils.ComputeGenomeLength { input: fasta = reference }
  
  call Utils.MergeFastqs { input: fastqs = fastqs }
  
  call Canu.Canu {
    input:
    reads = MergeFastqs.merged_fastq,
    prefix = prefix,
    genome_size =  ceil(ComputeGenomeLength.length),
    correct_error_rate = correct_error_rate,
    trim_error_rate = trim_error_rate,
    assemble_error_rate = assemble_error_rate
  }
  
  call Medaka.MedakaPolish {
    input:
    basecalled_reads = MergeFastqs.merged_fastq,
    draft_assembly = Canu.fa,
    model = medaka_model,
    prefix = basename(Canu.fa, ".fasta") + ".polished",
    n_rounds = 3
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
    prefix = prefix + ".canu"
  }
  
  call Quast.SummarizeQuastReport as summaryQ {input: quast_report_txt = Quast.report_txt}
  Map[String, String] q_metrics = read_map(summaryQ.quast_metrics[0])
  
  output {
    File asm_polished = Canu.fa
    
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
