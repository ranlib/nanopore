version 1.0

workflow ont_guppy_gpu {
  input {
    File fast5_dir
    String basecall_conf
    Int disksize = 300
  }
  
  call guppy_basecall_gpu {
    input:
    fast5_dir = fast5_dir,
    basecall_conf = basecall_conf,
    disksize = disksize
  }
  
  output {
    File output_bases = basecall.output_bases
  }
}

task guppy_basecall_gpu {
  input {
    String basecall_conf
    File fast5_dir
    Int disksize
  }
  
  command {
    set -o errexit
    set -o nounset
    set -o pipefail
    
    guppy_basecaller -i fast5_dir -s output_bases -c basecall_conf -x "cuda:0" --num_callers 14 --gpu_runners_per_device 8 --compress_fastq
    tar -czvf output_bases.tar.gz output_bases
  }
  
  output {
    File output_bases = "output_bases.tar.gz"
  }

  runtime {
    continueOnReturnCode: false
    docker: "genomicpariscentre/guppy-gpu"
    disks: "local-disk ${disksize} LOCAL"
    bootDiskSizeGb: 25
    gpuType: "nvidia-tesla-p100"
    gpuCount: 1
    memory: "64GB"
    cpu: 16
    zones: "us-central1-c"
  }
}
