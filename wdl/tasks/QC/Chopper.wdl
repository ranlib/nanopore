version 1.0

import "../../structs/Structs.wdl"

workflow wf_chopper {
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

  call chopper {
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
    File output_file = chopper.output_file
  }
}

task chopper {
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
    RuntimeAttr? runtime_attr_override
  }

  Int disk_size = 3*ceil(size(input_file, "GB"))
  String output_filename = sub(sub(basename(input_file),".fastq.gz$",""),".fq.gz$","") + "_chopper.fastq.gz"

  command {
    set -xe
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
      | gzip > ~{output_filename}
  }

  output {
    File output_file = output_filename
  }

  RuntimeAttr default_attr = object {
    cpu_cores:          2,
    mem_gb:             4,
    disk_gb:            disk_size,
    boot_disk_gb:       10,
    preemptible_tries:  2,
    max_retries:        1,
    docker:             "dbest/chopper:v0.8.0"
  }
  RuntimeAttr runtime_attr = select_first([runtime_attr_override, default_attr])
  runtime {
    cpu:                    select_first([runtime_attr.cpu_cores,         default_attr.cpu_cores])
    memory:                 select_first([runtime_attr.mem_gb,            default_attr.mem_gb]) + " GiB"
    disks: "local-disk " +  select_first([runtime_attr.disk_gb,           default_attr.disk_gb]) + " HDD"
    bootDiskSizeGb:         select_first([runtime_attr.boot_disk_gb,      default_attr.boot_disk_gb])
    preemptible:            select_first([runtime_attr.preemptible_tries, default_attr.preemptible_tries])
    maxRetries:             select_first([runtime_attr.max_retries,       default_attr.max_retries])
    docker:                 select_first([runtime_attr.docker,            default_attr.docker])
  }
}
