version 1.0

import "../Utilities/VariantUtils.wdl"
import "Sniffles2.wdl" as Sniffles2
import "Clair.wdl" as Clair3

workflow CallVariantsONT {
  
  meta {
    description: "A workflow for calling small and/or structural variants from an aligned ONT BAM file."
  }
  
  parameter_meta {
    bam: "ONT BAM file"
    bai: "ONT BAM index file"
    minsvlen: "Minimum SV length in bp (default: 50)"
    prefix: "Prefix for output files"
    sample_id: "Sample ID"
    
    ref_fasta: "Reference FASTA file"
    ref_fasta_fai: "Reference FASTA index file"
    ref_dict: "Reference FASTA dictionary file"
    
    call_svs: "Call structural variants"
    call_small_variants: "Call small variants"

    sites_vcf: "for use with Clair"
    sites_vcf_tbi: "for use with Clair"
  }
  
  input {
    File bam
    File bai
    Int minsvlen = 50
    String prefix
    String sample_id
    
    File ref_fasta
    File ref_fasta_fai
    File ref_dict
    
    Boolean call_svs
    
    Boolean call_small_variants
    File? sites_vcf
    File? sites_vcf_tbi
  }
  
  if (call_small_variants) {
    call Clair3.Clair {
      input:
      bam = bam,
      bai = bai,
      ref_fasta     = ref_fasta,
      ref_fasta_fai = ref_fasta_fai,
      sites_vcf = sites_vcf,
      sites_vcf_tbi = sites_vcf_tbi,
      preset = "ONT"
    }
  }
  
  if (call_svs) {
    call Sniffles2.SampleSV as Sniffles2SV {
      input:
      bam    = bam,
      bai    = bai,
      minsvlen = minsvlen,
      sample_id = sample_id,
      prefix = prefix
    }
    
    call VariantUtils.ZipAndIndexVCF as ZipAndIndexSnifflesVCF {
      input:
      vcf = Sniffles2SV.vcf
    }
  }
  
  output {
    File? sniffles_vcf = ZipAndIndexSnifflesVCF.vcfgz
    File? sniffles_tbi = ZipAndIndexSnifflesVCF.tbi

    # Clair output already zipped
    File? clair_vcf = Clair.vcf
    File? clair_tbi = Clair.vcf_tbi

    File? clair_gvcf = Clair.gvcf
    File? clair_gtbi = Clair.gvcf_tbi
  }
}
