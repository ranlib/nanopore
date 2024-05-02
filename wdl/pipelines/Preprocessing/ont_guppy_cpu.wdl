version 1.0

workflow ont_guppy_cpu {
  input {
    String basecall_config
    File fast5_file
    
    Int disksize_gb = 100
  }

  call guppy_basecall_cpu {
    input:
    fast5_file = fast5_file,
    basecall_config = basecall_config,
    disksize_gb = disksize_gb
  }
  
  output {
    File output_bases = guppy_basecall_cpu.output_bases
  }
}


task guppy_basecall_cpu {
  input {
    String basecall_config
    File fast5_file
    Int disksize_gb
    Int cpu = 64
    String memory = "64GB"
    String docker = "genomicpariscentre/guppy:latest"
  }
  
  command {
    set -x 
    mkdir ./fast5_dir/
    cp ${fast5_file} ./fast5_dir/
    guppy_basecaller -i ./fast5_dir/ -s guppy_output -c ~{basecall_config} --compress_fastq --num_callers 2 --cpu_threads_per_caller 1
    tar -czvf guppy_output.tar.gz guppy_output
  }
  
  output {
    File output_bases = "guppy_output.tar.gz"
  }

  runtime {
    docker: docker
    disks: "local-disk ${disksize_gb} LOCAL"
    memory: memory
    cpu: cpu
    continueOnReturnCode: false
  }
}
