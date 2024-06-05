version 1.0

workflow chopper_workflow {
  input {
    File input_file
    Int min_quality = 0
    Int max_quality = 1000
    Int min_length = 1
    Int max_length = 2147483647
    Int head_crop = 0
    Int tail_crop = 0
    Int threads = 4
    String? contam_file
    Boolean inverse = false
  }

  call chopper_task {
    input:
      input_file = input_file,
      min_quality = min_quality,
      max_quality = max_quality,
      min_length = min_length,
      max_length = max_length,
      head_crop = head_crop,
      tail_crop = tail_crop,
      threads = threads,
      contam_file = contam_file,
      inverse = inverse
  }

  output {
    File output_file = chopper_task.output_file
  }
}

task chopper_task {
  input {
    File input_file
    Int min_quality
    Int max_quality
    Int min_length
    Int max_length
    Int head_crop
    Int tail_crop
    Int threads
    String? contam_file
    Boolean inverse
  }

  command {
    chopper \
      -q ~{min_quality} \
      --maxqual ~{max_quality} \
      -l ~{min_length} \
      --maxlength ~{max_length} \
      --headcrop ~{head_crop} \
      --tailcrop ~{tail_crop} \
      -t ~{threads} \
      ~{if defined(contam_file) then "-c " + contam_file else ""} \
      ~{if inverse then "--inverse" else ""} \
      -i ~{input_file} \
      -o output.txt
  }

  output {
    File output_file = "output.txt"
  }

  runtime {
    docker: "dbest/chopper:v0.8.0"
    memory: "4G"
    cpu: threads
  }
}
