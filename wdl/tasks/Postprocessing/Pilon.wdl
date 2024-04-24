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
    your_tool_name \
      --genome ${genome_fasta} \
      ${" --frags " + frags_bam if defined(frags_bam)} \
      ${" --jumps " + jumps_bam if defined(jumps_bam)} \
      ${" --unpaired " + unpaired_bam if defined(unpaired_bam)} \
      ${" --sort" if sort} \
      ${" --iupac" if iupac} \
      ${" --nonpf" if nonpf} \
      ${" --targets " + join(",", targets) if defined(targets)} \
      ${" --verbose" if verbose} \
      ${" --debug" if debug} \
      ${" --version" if defined(version)} \
      ${" --defaultqual " + defaultqual if defined(defaultqual)} \
      ${" --flank " + flank if defined(flank)} \
      ${" --gapmargin " + gapmargin if defined(gapmargin)} \
      ${" --K " + K if defined(K)} \
      ${" --mindepth " + mindepth if defined(mindepth)} \
      ${" --mingap " + mingap if defined(mingap)} \
      ${" --minmq " + minmq if defined(minmq)} \
      ${" --minqual " + minqual if defined(minqual)} \
      ${" --nostrays" if nostrays}
  >>>
  output {
    // Define your output files here if applicable
  }
  runtime {
    docker: "dbest/pilon:v1.0"
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
    // Define your workflow outputs here if applicable
  }
}
