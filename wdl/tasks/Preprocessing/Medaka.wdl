version 1.0

import "../../structs/Structs.wdl"

task MedakaPolish {
  
  meta {
    description: "Polish an ONT draft assembly with GUPPY basecalled ONT reads. Runs within a few hours with 18GB basecalled_reads and a 23Mb genome"
  }
  parameter_meta {
    basecalled_reads:   "basecalled reads to be used with polishing"
    draft_assembly:     "draft assembly to be polished"
    prefix:             "prefix for output files"
    model:              "run `medaka tools list_models` and pick string with the correct pore type, machine, and guppy version"
    n_rounds:           "number of polishing rounds to apply"
  }
    
  input {
    File basecalled_reads
    File draft_assembly
    String prefix = "consensus"
    String model = "r941_prom_high_g360"
    Int n_rounds = 1
    RuntimeAttr? runtime_attr_override
  }
  

  Int disk_size = 4 * n_rounds * ceil(size([basecalled_reads, draft_assembly], "GB"))

  RuntimeAttr default_attr = object {
    cpu_cores:              8,
    mem_gb:                 24,
    disk_gb:                disk_size,
    boot_disk_gb:           10,
    preemptible_tries:      0,
    max_retries:            0,
    docker:                 "ontresearch/medaka:1.11.3"
  }
  RuntimeAttr runtime_attr = select_first([runtime_attr_override, default_attr])

  Int n_cores = select_first([runtime_attr.cpu_cores, default_attr.cpu_cores])
  
  command <<<
    source /medaka/venv/bin/activate
    
    set -euxo pipefail
    
    mkdir output_0_rounds
    cp ~{draft_assembly} output_0_rounds/consensus.fasta
    
    for i in {1..~{n_rounds}}
    do
    medaka_consensus -i ~{basecalled_reads} -d output_$((i-1))_rounds/consensus.fasta -o output_${i}_rounds -t ~{n_cores} -m ~{model}
    done
    
    cp output_~{n_rounds}_rounds/consensus.fasta ~{prefix}.fasta
  >>>
  
  output {
    File polished_assembly = "~{prefix}.fasta"
  }
  
  runtime {
    cpu:                    select_first([runtime_attr.cpu_cores, default_attr.cpu_cores])
    memory:                 select_first([runtime_attr.mem_gb, default_attr.mem_gb]) + " GiB"
    disks:  "local-disk " + select_first([runtime_attr.disk_gb, default_attr.disk_gb]) + " HDD"
    bootDiskSizeGb:         select_first([runtime_attr.boot_disk_gb, default_attr.boot_disk_gb])
    preemptible:            select_first([runtime_attr.preemptible_tries, default_attr.preemptible_tries])
    maxRetries:             select_first([runtime_attr.max_retries, default_attr.max_retries])
    gpuType:                "nvidia-tesla-t4"
    gpuCount:               1
    zones:                  ["us-east1-c"]
    cpuPlatform:            "Intel Haswell"
    docker:                 select_first([runtime_attr.docker, default_attr.docker])
  }
}

