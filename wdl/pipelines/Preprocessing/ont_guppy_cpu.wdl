version 1.0

workflow ont_guppy_cpu {
  input {
    String basecall_config
    String? barcode_kit
    File fast5_file
    
    Int disksize_gb = 100
  }

  call guppy_basecall_cpu {
    input:
    fast5_file = fast5_file,
    basecall_config = basecall_config,
    barcode_kit = barcode_kit,
    disksize_gb = disksize_gb
  }
  
  output {
    File output_bases = guppy_basecall_cpu.output_bases
  }
}


task guppy_basecall_cpu {
  input {
    String basecall_config
    String? barcode_kit
    File fast5_file
    Int disksize_gb
    Int cpu = 64
    String memory = "64GB"
    String docker = "genomicpariscentre/guppy:latest"
  }

  String barcode_arg = if defined(barcode_kit) then "--barcode_kits \"~{barcode_kit}\" --enable_trim_barcodes" else ""
  
  command {
    set -xe 
    mkdir ./fast5_dir/
    cp ${fast5_file} ./fast5_dir/
    guppy_basecaller -i ./fast5_dir/ -s guppy_output -c ~{basecall_config} ~{barcode_arg} --compress_fastq
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
