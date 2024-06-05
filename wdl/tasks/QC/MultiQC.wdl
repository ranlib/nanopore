version 1.0

workflow wf_multiqc {
  input {
    Array[File] inputFiles
    String outputPrefix
  }

  call task_multiqc {
    input:
    inputFiles = inputFiles,
    outputPrefix = outputPrefix
  }

  output {
    File report = task_multiqc.report
  }

  meta {
    author: "Dieter Best"
    email: "Dieter.Best@cdph.ca.gov"
    description: "Multi QC workflow: Produce QC reports for a number of tasks"
  }

  parameter_meta {
    ## inputs
    inputFiles: {description: "List of input files to run QC on.", category: "required"}
    outputPrefix: {description: "output prefix.", category: "required"}
    ## output
    report: {description: "output html file."}
  }
}

task task_multiqc {
  input {
    Array[File] inputFiles
    String outputPrefix
    String docker = "multiqc/multiqc:v1.21"
    String memory = "8GB"
  }
  
  command <<<
    set -ex
    for file in ~{sep=' ' inputFiles}; do
    if [ -e $file ] ; then
    cp $file .
    else
    echo "<W> multiqc: $file does not exist!"
    fi
    done
    multiqc --force --no-data-dir -n ~{outputPrefix}.multiqc .
  >>>

  output {
    File report = "${outputPrefix}.multiqc.html"
  }

  runtime {
    docker: docker
    memory: memory
  }
}

