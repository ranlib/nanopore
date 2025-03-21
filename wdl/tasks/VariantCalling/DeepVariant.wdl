version 1.0

import "../../structs/Structs.wdl"


workflow DeepVariant {

    meta {
        description: "Workflow for getting VCF and gVCF from DeepVariant. Note VCF is un-phased."
    }

    input {
        File bam
        File bai
        File ref_fasta
        File ref_fasta_fai
        Int dv_threads
        Int dv_memory
        String zones = "us-central1-b us-central1-c"
    }

    parameter_meta {
        # when running large scale workflows, we sometimes see errors like the following
        #   A resource limit has delayed the operation: generic::resource_exhausted: allocating: selecting resources: selecting region and zone:
        #   no available zones: 2763 LOCAL_SSD_TOTAL_GB (738/30000 available) usage too high
        zones: "select which zone (GCP) to run this task"
    }

    call DV as deep_variant {
        input:
            bam = bam,
            bai = bai,
            ref_fasta = ref_fasta,
            ref_fasta_fai = ref_fasta_fai,
            threads = dv_threads,
            memory = dv_memory,
            zones = zones
    }

    output {
        File VCF        = deep_variant.VCF
        File VCF_tbi    = deep_variant.VCF_tbi

        File gVCF       = deep_variant.gVCF
        File gVCF_tbi   = deep_variant.gVCF_tbi
    }
}

task DV {

    input {
        File bam
        File bai

        File ref_fasta
        File ref_fasta_fai

        Int threads
        Int memory
        String zones

        RuntimeAttr? runtime_attr_override
    }

    String prefix = basename(bam, ".bam") + ".deepvariant"
    Int bam_sz = ceil(size(bam, "GB"))
    Boolean is_big_bam = bam_sz > 100
    Int inflation_factor = if (is_big_bam) then 10 else 5
    Int minimal_disk = 1000
    Int disk_size = if inflation_factor * bam_sz > minimal_disk then inflation_factor * bam_sz else minimal_disk

    command <<<
        set -euxo pipefail
        num_core=$(cat /proc/cpuinfo | awk '/^processor/{print $3}' | wc -l)
        /opt/deepvariant/bin/run_deepvariant \
            --model_type=WGS \
            --ref=~{ref_fasta} \
            --reads=~{bam} \
            --output_vcf=~{prefix}.vcf.gz \
            --output_gvcf=~{prefix}.g.vcf.gz \
            --num_shards="${num_core}"
    >>>

    output {
      File VCF        = prefix + ".vcf.gz"
      File VCF_tbi    = prefix + ".vcf.gz.tbi"
      File gVCF       = prefix + ".gvcf.gz"
      File gVCF_tbi   = prefix + ".gvcf.gz.tbi"
      File visual_report_html = prefix + ".visual_report.html"
    }
    
    #########################
    RuntimeAttr default_attr = object {
      cpu_cores:          threads,
      mem_gb:             memory,
      disk_gb:            disk_size,
      boot_disk_gb:       100,
      preemptible_tries:  3,
      max_retries:        0,
      docker:             "google/deepvariant:1.6.1"
    }
    RuntimeAttr runtime_attr = select_first([runtime_attr_override, default_attr])
    runtime {
        cpu:                    select_first([runtime_attr.cpu_cores,         default_attr.cpu_cores])
        memory:                 select_first([runtime_attr.mem_gb,            default_attr.mem_gb]) + " GiB"
        disks: "local-disk " +  select_first([runtime_attr.disk_gb,           default_attr.disk_gb]) + " HDD"
        zones: zones
        bootDiskSizeGb:         select_first([runtime_attr.boot_disk_gb,      default_attr.boot_disk_gb])
        preemptible:            select_first([runtime_attr.preemptible_tries, default_attr.preemptible_tries])
        maxRetries:             select_first([runtime_attr.max_retries,       default_attr.max_retries])
        docker:                 select_first([runtime_attr.docker,            default_attr.docker])
    }
}
