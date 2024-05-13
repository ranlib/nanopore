version 1.0

task PlasForestTask {
  input {
    File input_file
    String output_file
    Boolean show_best_hit
    Boolean keep_features
    Int threads
    Int size_of_batch
    Boolean reassign_contigs
    File model_file
    File database_file
    Boolean verbose_mode
  }

  command <<<
    set -x
    PlasForest.py -i ~{input_file} -o ~{output_file} \
    ~{if show_best_hit then "-b" else ""} \
    ~{if keep_features then "-f" else ""} \
    ~{"--threads " + threads} \
    ~{"--size_of_batch " + size_of_batch} \
    ~{if reassign_contigs then "-r" else ""} \
    ~{"--model " + model_file} \
    ~{"--database " + database_file} \
    ~{if verbose_mode then "-v" else ""}
  >>>

  output {
    File output_csv = "${output_file}.csv"
  }

  runtime {
    docker: "dbest/plasforest:v1.4"
  }
}

workflow PlasForestWorkflow {
  input {
    File input_file
    String output_file
    Boolean show_best_hit
    Boolean keep_features
    Int threads
    Int size_of_batch
    Boolean reassign_contigs
    File model_file
    File database_file
    Boolean verbose_mode
  }

  call PlasForestTask {
    input: 
    input_file = input_file,
    output_file = output_file,
    show_best_hit = show_best_hit,
    keep_features = keep_features,
    threads = threads,
    size_of_batch = size_of_batch,
    reassign_contigs = reassign_contigs,
    model_file = model_file,
    database_file = database_file,
    verbose_mode = verbose_mode
  }

  output {
    File output_csv = PlasForestTask.output_csv
  }
}
