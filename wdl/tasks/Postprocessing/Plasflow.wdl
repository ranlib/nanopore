version 1.0

task Plasflow {
  input {
    File input_file
    String output_file_name
    Float threshold = 0.7
  }

  command <<<
    set -x
    PlasFlow.py --input ~{input_file} --output ~{output_file_name} --threshold ~{threshold}
  >>>

  output {
    File output_file = output_file_name
  }

  runtime {
    docker: "dbest/plasflow:latest"
  }
}

workflow PlasflowWorkflow {
  input {
    File input_file
    String output_file_name
    Float threshold
  }
  
  call Plasflow {
    input: 
    input_file = input_file,
    output_file_name = output_file_name,
    threshold = threshold
  }
  
  output {
    File output_file = Plasflow.output_file
  }
}
