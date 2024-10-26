version 1.0

import "../Utilities/Utils.wdl"
import "../Visualization/NanoPlot.wdl" as NP

workflow SampleLevelAlignedMetrics {

  meta {
    description: "A utility (sub-)workflow to compute coverage on sample-level BAM, and optionally over a provided BED file"
  }
  
  parameter_meta {
    aligned_bam: "Aligned BAM file"
    aligned_bai: "Index for the aligned BAM file"
    ref_fasta: "Reference FASTA file"
    bed_to_compute_coverage: "Optional BED file to compute coverage over"
  }
  
  input {
    File aligned_bam
    File aligned_bai
    
    File ref_fasta
  }
  
  call Utils.ComputeGenomeLength { input: fasta = ref_fasta }
  call NP.NanoPlotFromBam { input: bam = aligned_bam, bai = aligned_bai }
  
  output {
    Float aligned_num_reads = NanoPlotFromBam.stats_map['number_of_reads']
    Float aligned_num_bases = NanoPlotFromBam.stats_map['number_of_bases_aligned']
    Float aligned_frac_bases = NanoPlotFromBam.stats_map['fraction_bases_aligned']
    Float aligned_est_fold_cov = NanoPlotFromBam.stats_map['number_of_bases_aligned']/ComputeGenomeLength.length
    
    Float aligned_read_length_mean = NanoPlotFromBam.stats_map['mean_read_length']
    Float aligned_read_length_median = NanoPlotFromBam.stats_map['median_read_length']
    Float aligned_read_length_stdev = NanoPlotFromBam.stats_map['read_length_stdev']
    Float aligned_read_length_N50 = NanoPlotFromBam.stats_map['n50']
    
    Float average_identity = NanoPlotFromBam.stats_map['average_identity']
    Float median_identity = NanoPlotFromBam.stats_map['median_identity']
    
    Map[String, Float] reads_stats = NanoPlotFromBam.stats_map
    
    File stats = NanoPlotFromBam.stats
    File map = write_map(NanoPlotFromBam.stats_map)
  }
}
