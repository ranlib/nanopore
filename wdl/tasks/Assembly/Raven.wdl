version 1.0

import "../../structs/Structs.wdl"

task Raven {
  input {
    File sequences
    Int kmer_len = 15
    Int window_len = 5
    Float frequency = 0.001
    Float identity = 0.0
    Int kMaxNumOverlaps = 32
    Boolean use_micromizers = false
    Int polishing_rounds = 2
    Int match = 3
    Int mismatch = -5
    Int gap = -4
    Int min_unitig_size = 9999
    String? graphical_fragment_assembly
    String? unitig_graphical_fragment_assembly
    Boolean resume = false
    Boolean disable_checkpoints = false

    RuntimeAttr? runtime_attr_override
  }
  
  Int disk_size = 10 * ceil(size(sequences, "GB"))

  command <<<
    set -ex
    num_core=$(cat /proc/cpuinfo | awk '/^processor/{print $3}' | wc -l)
    raven \
    --kmer-len ~{kmer_len} \
    --window-len ~{window_len} \
    --frequency ~{frequency} \
    --identity ~{identity} \
    --kMaxNumOverlaps ~{kMaxNumOverlaps} \
    ~{if use_micromizers then "--use-micromizers" else ""} \
    --polishing-rounds ~{polishing_rounds} \
    --match ~{match} \
    --mismatch ~{mismatch} \
    --gap ~{gap} \
    --min-unitig-size ~{min_unitig_size} \
    ~{if defined(graphical_fragment_assembly) then "--graphical-fragment-assembly " + graphical_fragment_assembly else ""} \
    ~{if defined(unitig_graphical_fragment_assembly) then "--unitig-graphical-fragment-assembly " + unitig_graphical_fragment_assembly else ""} \
    ~{if resume then "--resume" else ""} \
    ~{if disable_checkpoints then "--disable-checkpoints" else ""} \
    --threads ${num_core} \
    ~{sequences} > output.fasta
  >>>
  
  output {
    File output_fasta = "output.fasta"
    File? graphical_fragment_assembly_file = graphical_fragment_assembly
    File? unitig_graphical_fragment_assembly_file = unitig_graphical_fragment_assembly
  }
  
  RuntimeAttr default_attr = object {
    cpu_cores:          16,
    mem_gb:             100,
    disk_gb:            disk_size,
    boot_disk_gb:       10,
    preemptible_tries:  0,
    max_retries:        0,
    docker:             "dbest/raven:v1.8.3"
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

workflow raven_workflow {
    input {
        File sequences
        Int kmer_len = 15
        Int window_len = 5
        Float frequency = 0.001
        Float identity = 0.0
        Int kMaxNumOverlaps = 32
        Boolean use_micromizers = false
        Int polishing_rounds = 2
        Int match = 3
        Int mismatch = -5
        Int gap = -4
        Int min_unitig_size = 9999
        String? graphical_fragment_assembly
        String? unitig_graphical_fragment_assembly
        Boolean resume = false
        Boolean disable_checkpoints = false
    }

    call Raven {
        input:
            sequences = sequences,
            kmer_len = kmer_len,
            window_len = window_len,
            frequency = frequency,
            identity = identity,
            kMaxNumOverlaps = kMaxNumOverlaps,
            use_micromizers = use_micromizers,
            polishing_rounds = polishing_rounds,
            match = match,
            mismatch = mismatch,
            gap = gap,
            min_unitig_size = min_unitig_size,
            graphical_fragment_assembly = graphical_fragment_assembly,
            unitig_graphical_fragment_assembly = unitig_graphical_fragment_assembly,
            resume = resume,
            disable_checkpoints = disable_checkpoints
    }

    output {
        File output_fasta = Raven.output_fasta
        File? graphical_fragment_assembly_file = Raven.graphical_fragment_assembly_file
        File? unitig_graphical_fragment_assembly_file = Raven.unitig_graphical_fragment_assembly_file
    }
}
