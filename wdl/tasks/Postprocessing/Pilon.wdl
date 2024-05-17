version 1.0

task Pilon {
  input {
    File genome_fasta
    File frags_bam
    File frags_bai
    Array[String]? targets
    String output_prefix = "out"
    Boolean sort = true
    Boolean iupac = true
    Boolean nonpf = false
    Boolean verbose = true
    Boolean debug = true
    Boolean nostrays = true
    Int defaultqual = 10
    Int flank = 10
    Int gapmargin = 100000
    Int K = 47
    Int mingap = 10
    Int minmq = 0
    Int minqual = 0
    Float mindepth = 1
  }
  
  command <<<
    set -xe
    
    cp ~{frags_bam} ./in.bam
    cp ~{frags_bai} ./in.bam.bai
    
    pilon \
    --genome ~{genome_fasta} \
    --changes \
    --vcf \
    --outdir ./results \
    --output ~{output_prefix} \
    --frags ./in.bam
  >>>

  output {
    File polished_fasta = "./results/~{output_prefix}.fasta"
    File changes = "./results/~{output_prefix}.changes"
    File vcf = "./results/~{output_prefix}.vcf"
  }

  runtime {
    docker: "dbest/pilon:v1.24"
  }
}

workflow PilonWorkflow {
  input {
    File genome_fasta
    File frags_bam
    File frags_bai
    String output_prefix
    Array[String]? targets
    Boolean sort
    Boolean iupac
    Boolean nonpf
    Boolean verbose
    Boolean debug
    Boolean nostrays
    Int defaultqual
    Int flank
    Int gapmargin
    Int K
    Int mingap
    Int minmq
    Int minqual
    Float mindepth
  }

  call Pilon {
    input:
    genome_fasta = genome_fasta,
    output_prefix = output_prefix,
    frags_bam = frags_bam,
    frags_bai = frags_bai
  }

  output {
    File polished_fasta = Pilon.polished_fasta
    File vcf = Pilon.vcf
    File changes = Pilon.changes
  }
}
