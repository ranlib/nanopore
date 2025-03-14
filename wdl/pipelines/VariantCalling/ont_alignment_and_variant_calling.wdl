version 1.0

import "../../tasks/Alignment/AlignReads.wdl" as Align
import "../../tasks/Utilities/Utils.wdl" as Utils
import "../../tasks/Utilities/VariantUtils.wdl"as VariantUtils
import "../../tasks/VariantCalling/CallVariantsONT.wdl" as VAR
import "../../tasks/QC/SampleLevelAlignedMetrics.wdl" as COV
import "../../pipelines/Annotation/task_snpEff.wdl" as snpEff

workflow ont_variant_calling {
  
  meta {
    description: "Perform alignment and variant calling."
  }
  
  parameter_meta {
    reads: { description: "list of input single end fastq files" }
    ref_fasta: { description: "reference sequence"}
    prefix: { description: "prefix for output files"}
  }
  
  input {
    Array[File]+ reads
    #File ref_fasta
    String RG
    String map_preset
    String? library
    Array[String] tags_to_preserve = []
    #String prefix = "out"
    RuntimeAttr? runtime_attr_override

    File reference
    File reference_fai
    File reference_dict
    
    String sample_name
    
    Boolean call_svs = true
    
    Boolean call_small_variants = true
    File? sites_vcf
    File? sites_vcf_tbi

    Boolean call_snpEff = true
    File dataDir
    File config
    String genome
  }
 
  call Align.Minimap2 {
    input:
    reads = reads,
    ref_fasta = reference,
    RG = RG,
    map_preset = map_preset,
    library = library,
    tags_to_preserve = tags_to_preserve,
    prefix = sample_name,
    runtime_attr_override = runtime_attr_override
  }
   
  call COV.SampleLevelAlignedMetrics as coverage {
    input:
    aligned_bam = Minimap2.aligned_bam,
    aligned_bai = Minimap2.aligned_bai,
    ref_fasta   = reference
  }
  
  if (call_svs || call_small_variants) {
    call Utils.Faidx
      input:
      fasta = reference
    }

    call Utils.Dict
      input:
      fasta = reference
    }
  
    call VAR.CallVariantsONT {
      input:
      bam               = Minimap2.aligned_bam,
      bai               = Minimap2.aligned_bai,
      sample_id         = sample_name,
      ref_fasta         = reference,
      ref_fasta_fai     = Faidx.fai,
      ref_dict          = Dict.dict,
      prefix            = sample_name,
      call_svs          = call_svs,
      call_small_variants = call_small_variants,
      sites_vcf         = sites_vcf,
      sites_vcf_tbi     = sites_vcf_tbi
    }

    if ( call_snpEff ) {
      # Clair3
      String annotated_clair_vcf = sample_name + "_clair_snpEff.vcf"
      call snpEff.task_snpEff as annotate_clair_vcf {
	      input:
        vcf = select_first([CallVariantsONT.clair_vcf]),
        genome = genome,
        config = config,
        dataDir = dataDir,
        outputPath = annotated_clair_vcf
      }

      call VariantUtils.ZipAndIndexVCF as ZipAndIndexClairVCF {
        input:
        vcf = annotate_clair_vcf.outputVcf
      }

      # Sniffles
      String annotated_sniffles_vcf = sample_name + "_sniffles_snpEff.vcf"
      call snpEff.task_snpEff as annotate_sniffles_vcf {
        input:
        vcf = select_first([CallVariantsONT.sniffles_vcf]),
        genome = genome,
        config = config,
        dataDir = dataDir,
        outputPath = annotated_sniffles_vcf
      }

      call VariantUtils.ZipAndIndexVCF as ZipAndIndexSnifflesVCF {
        input:
        vcf = annotate_sniffles_vcf.outputVcf
      }

      # merge
      call VariantUtils.MergeAndSortVCFs {
        input:
        prefix = sample_name,
        vcfs = [ annotate_clair_vcf.outputVcf, annotate_sniffles_vcf.outputVcf ],
      	ref_fasta_fai = reference_fai
      }
    }
  }
    
  output {
    File aligned_bam = Minimap2.aligned_bam
    File aligned_bai = Minimap2.aligned_bai

    Float aligned_num_reads = coverage.aligned_num_reads
    Float aligned_num_bases = coverage.aligned_num_bases
    Float aligned_frac_bases = coverage.aligned_frac_bases
    Float aligned_est_fold_cov = coverage.aligned_est_fold_cov
    
    Float aligned_read_length_mean = coverage.aligned_read_length_mean
    Float aligned_read_length_median = coverage.aligned_read_length_median
    Float aligned_read_length_stdev = coverage.aligned_read_length_stdev
    Float aligned_read_length_N50 = coverage.aligned_read_length_N50
    
    Float average_identity = coverage.average_identity
    Float median_identity = coverage.median_identity

    File? sniffles_vcf = CallVariantsONT.sniffles_vcf
    File? sniffles_tbi = CallVariantsONT.sniffles_tbi
    
    File? clair_vcf = CallVariantsONT.clair_vcf
    File? clair_tbi = CallVariantsONT.clair_tbi
    
    File? clair_gvcf = CallVariantsONT.clair_gvcf
    File? clair_gtbi = CallVariantsONT.clair_gtbi

    # snpEff annotation of Clair
    File? clair_snpEff_vcf = annotate_clair_vcf.outputVcf
    File? clair_snpEff_summary_csv = annotate_clair_vcf.snpEff_summary_csv 
    File? clair_snpEff_summary_html = annotate_clair_vcf.snpEff_summary_html
    File? clair_snpEff_vcfgz = ZipAndIndexClairVCF.vcfgz
    File? clair_snpEff_tbi = ZipAndIndexClairVCF.tbi
    
    # snpEff annotation of Sniffles
    File? sniffles_snpEff_vcf = annotate_sniffles_vcf.outputVcf
    File? sniffles_snpEff_summary_csv = annotate_sniffles_vcf.snpEff_summary_csv 
    File? sniffles_snpEff_summary_html = annotate_sniffles_vcf.snpEff_summary_html
    File? sniffles_snpEff_vcfgz = ZipAndIndexSnifflesVCF.vcfgz
    File? sniffles_snpEff_tbi = ZipAndIndexSnifflesVCF.tbi

    # merged
    File? merged_vcf = MergeAndSortVCFs.vcf
    File? merged_tbi = MergeAndSortVCFs.tbi
  }
}
