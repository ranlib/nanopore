version 1.0

import "../../structs/Structs.wdl"

workflow Flye {

    meta {
        description: "Assemble a genome using Flye"
    }

    parameter_meta {
      reads: "Input reads (in fasta or fastq format, compressed or uncompressed)"
      read_type: "read type for running flye"
      prefix: "Prefix to apply to assembly output filenames"
    }

    input {
      File reads
      String prefix
      String read_type = "nano-raw"
    }

    call Assemble {
      input:
      reads  = reads,
      read_type = read_type,
      prefix = prefix
    }

    output {
      Array[File] assembly_files = Assemble.assembly_files
      File gfa = Assemble.gfa
      File fa = Assemble.fa
    }
}

task Assemble {
  parameter_meta {
    reads:    "reads (in fasta or fastq format, compressed or uncompressed)"
    prefix:   "prefix to apply to assembly output filenames"
  }
  
  input {
    File reads
    String prefix = "out"
    String read_type = "nano-raw"
    Float? genome_length
    RuntimeAttr? runtime_attr_override
  }
  
  Int disk_size = 10 * ceil(size(reads, "GB"))
  
  RuntimeAttr default_attr = object {
    cpu_cores:          16,
    mem_gb:             100,
    disk_gb:            disk_size,
    boot_disk_gb:       10,
    preemptible_tries:  0,
    max_retries:        0,
    docker:             "dbest/flye:v2.9.5"
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

  Int cpus = select_first([runtime_attr.cpu_cores, default_attr.cpu_cores])
  Int genome_size = if defined(genome_length) then ceil(genome_length) else ""
  
  command <<<
    set -euxo pipefail
    
    if [[ ~{cpus} ]] ; then
      num_core=$(cat /proc/cpuinfo | awk '/^processor/{print $3}' | wc -l)
    else
      num_core=~{runtime_attr.cpu_cores}
    fi  
    
    read_arg="--nano-raw"
    if [[ ~{read_type} == "nano-raw" ]]; then
      read_arg="--nano-raw"
    elif [[ ~{read_type} == "nano-corr" ]]; then
      read_arg="--nano-corr"
    elif [[ ~{read_type} == "nano-hq" ]]; then
      read_arg="--nano-hq"
    else
      read_arg="--nano-raw"
    fi
    
    flye ${read_arg} ~{reads} --threads ${num_core} \
    ~{true="--genome_size" false="" defined(genome_length)} ~{genome_size} \
    --out-dir asm
    
    mv asm/assembly.fasta ~{prefix}.flye.fa
    mv asm/assembly_graph.gfa ~{prefix}.flye.gfa
  >>>
  
  output {
    Array[File] assembly_files = glob("asm/*")    
    File gfa = "~{prefix}.flye.gfa"
    File fa = "~{prefix}.flye.fa"
  }
  
}
