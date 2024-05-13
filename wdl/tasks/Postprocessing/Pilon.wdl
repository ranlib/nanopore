version 1.0

task Pilon {
  input {
    File genome_fasta
    File? frags_bam
    File? jumps_bam
    File? unpaired_bam
    Boolean sort
    Boolean iupac
    Boolean nonpf
    Array[String]? targets
    Boolean verbose
    Boolean debug
    Boolean? version
    Int defaultqual
    Int flank
    Int gapmargin
    Int K
    Float mindepth
    Int mingap
    Int minmq
    Int minqual
    Boolean nostrays
  }
  
  command <<<
    pilon \
      --genome ~{genome_fasta} \
      ~{if defined(frags_bam) then " --frags " + frags_bam else ""}

  >>>

  output {
  }

  runtime {
    docker: "dbest/pilon:v1.24"
  }
}

workflow PilonWorkflow {
  input {
    File genome_fasta
    File? frags_bam
    File? jumps_bam
    File? unpaired_bam
    Boolean sort
    Boolean iupac
    Boolean nonpf
    Array[String]? targets
    Boolean verbose
    Boolean debug
    Boolean? version
    Int defaultqual
    Int flank
    Int gapmargin
    Int K
    Float mindepth
    Int mingap
    Int minmq
    Int minqual
    Boolean nostrays
  }
  
  call Pilon {
    input:
      genome_fasta = genome_fasta,
      frags_bam = frags_bam,
      jumps_bam = jumps_bam,
      unpaired_bam = unpaired_bam,
      sort = sort,
      iupac = iupac,
      nonpf = nonpf,
      targets = targets,
      verbose = verbose,
      debug = debug,
      version = version,
      defaultqual = defaultqual,
      flank = flank,
      gapmargin = gapmargin,
      K = K,
      mindepth = mindepth,
      mingap = mingap,
      minmq = minmq,
      minqual = minqual,
      nostrays = nostrays
  }

  output {
  }
}
