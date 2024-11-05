version 1.0

workflow wf_bcftools_stats {
  meta {
    description: "Get summary statistics from list of input variant call vcf files"
  }
  
  parameter_meta {
    input_vcf: "List of input variant call vcf files"
    options: "String of options for bcftools stats"
  }
  
  input {
    Array[File]+ input_vcf # Primary VCF file (A.vcf.gz)
    String options = "" # Optional bcftools stats options
  }

  call task_bcftools_stats {
    input:
    input_vcf = input_vcf,
    options = options
  }

  output {
    File stats_output = task_bcftools_stats.stats_output
  }
}

task task_bcftools_stats {
  input {
    Array[File]+ input_vcf
    String? options
    String docker = "biocontainers/bcftools:v1.12-1-deb_cv1"
    String memory = "2GB"
  }

  command <<<
    bcftools stats ~{options} ~{sep=' ' input_vcf}
  >>>

  output {
    File stats_output = "stats.txt"
  }

  runtime {
    docker: docker
    memory: memory
    cpu: 1
  }
}
