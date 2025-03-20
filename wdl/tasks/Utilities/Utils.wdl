version 1.0

import "../../structs/Structs.wdl"

task ComputeGenomeLength {

    meta {
        description: "Utility to compute the length of a genome from a FASTA file"
    }

    parameter_meta {
        fasta:  "FASTA file"
    }

    input {
        File fasta

        RuntimeAttr? runtime_attr_override
    }

    Int disk_size = 2*ceil(size(fasta, "GB"))

    command <<<
        set -euxo pipefail

        samtools dict ~{fasta} | \
            grep '^@SQ' | \
            awk '{ print $3 }' | \
            sed 's/LN://' | \
            awk '{ sum += $1 } END { print sum }' > length.txt
    >>>

    output {
        Float length = read_float("length.txt")
    }

    RuntimeAttr default_attr = object {
        cpu_cores:          1,
        mem_gb:             1,
        disk_gb:            disk_size,
        boot_disk_gb:       10,
        preemptible_tries:  0,
        max_retries:        0,
        docker:             "dbest/samtools:v1.21"
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


task MergeFastqs {

    meta {
        description : "Merge fastq files."
    }

    parameter_meta {
        fastqs: "Fastq files to be merged."
        prefix: "Prefix for the output fastq file."
        runtime_attr_override: "Override the default runtime attributes."
    }

    input {
        Array[File] fastqs

        String prefix = "merged"

        RuntimeAttr? runtime_attr_override
    }

    Int disk_size = 3 * ceil(size(fastqs, "GB"))

    String disk_type = if disk_size < 375 then "LOCAL" else "HDD"

    Int memory = 8

    command <<<
        FILE="~{fastqs[0]}"
        if [[ "$FILE" =~ \.gz$ ]]; then
            cat ~{sep=' ' fastqs} > ~{prefix}.fq.gz
        else
            cat ~{sep=' ' fastqs} | gzip > ~{prefix}.fq.gz
        fi
    >>>

    output {
        File merged_fastq = "~{prefix}.fq.gz"
    }

    RuntimeAttr default_attr = object {
        cpu_cores:          2,
        mem_gb:             memory,
        disk_gb:            disk_size,
        boot_disk_gb:       10,
        preemptible_tries:  0,
        max_retries:        0,
        docker:             "ubuntu:24.04"
    }
    RuntimeAttr runtime_attr = select_first([runtime_attr_override, default_attr])
    runtime {
        cpu:                    select_first([runtime_attr.cpu_cores,         default_attr.cpu_cores])
        memory:                 select_first([runtime_attr.mem_gb,            default_attr.mem_gb]) + " GiB"
        disks: "local-disk " +  select_first([runtime_attr.disk_gb,           default_attr.disk_gb]) + " ~{disk_type}"
        bootDiskSizeGb:         select_first([runtime_attr.boot_disk_gb,      default_attr.boot_disk_gb])
        preemptible:            select_first([runtime_attr.preemptible_tries, default_attr.preemptible_tries])
        maxRetries:             select_first([runtime_attr.max_retries,       default_attr.max_retries])
        docker:                 select_first([runtime_attr.docker,            default_attr.docker])
    }
}

task MergeBams {

    meta {
        description : "Merge several input BAMs into a single BAM."
    }

    parameter_meta {
        bams: "Input array of BAMs to be merged."
        prefix: "Prefix for the output BAM."
        runtime_attr_override: "Override the default runtime attributes."
    }

    input {
        Array[File] bams
        String prefix = "out"

        RuntimeAttr? runtime_attr_override
    }

    Int disk_size = 1 + 4*ceil(size(bams, "GB"))

    command <<<
        set -euxo pipefail

        samtools merge \
            -p -c --no-PG \
            -@ 2 \
            --write-index \
            -o "~{prefix}.bam##idx##~{prefix}.bam.bai" \
            ~{sep=" " bams}
    >>>

    output {
        File merged_bam = "~{prefix}.bam"
        File merged_bai = "~{prefix}.bam.bai"
    }

    RuntimeAttr default_attr = object {
        cpu_cores:          4,
        mem_gb:             20,
        disk_gb:            disk_size,
        boot_disk_gb:       10,
        preemptible_tries:  0,
        max_retries:        0,
        docker:             "dbest/samtools:v1.21"
    }
    RuntimeAttr runtime_attr = select_first([runtime_attr_override, default_attr])
    runtime {
        cpu:                    select_first([runtime_attr.cpu_cores,         default_attr.cpu_cores])
        memory:                 select_first([runtime_attr.mem_gb,            default_attr.mem_gb]) + " GiB"
        disks: "local-disk " +  select_first([runtime_attr.disk_gb,           default_attr.disk_gb]) + " SSD"
        bootDiskSizeGb:         select_first([runtime_attr.boot_disk_gb,      default_attr.boot_disk_gb])
        preemptible:            select_first([runtime_attr.preemptible_tries, default_attr.preemptible_tries])
        maxRetries:             select_first([runtime_attr.max_retries,       default_attr.max_retries])
        docker:                 select_first([runtime_attr.docker,            default_attr.docker])
    }
}

task Index {

    meta {
        description : "samtools index a BAM file."
    }

    parameter_meta {
        bam: "BAM file to be indexed."
        runtime_attr_override: "Override the default runtime attributes."
    }

    input {
        File bam

        RuntimeAttr? runtime_attr_override
    }

    Int disk_size = 1 + 2*ceil(size(bam, "GB"))

    String prefix = basename(bam)

    command <<<
        set -euxo pipefail

        mv ~{bam} ~{prefix}
        samtools index ~{basename(prefix)}
    >>>

    output {
        File bai = "~{prefix}.bai"
    }

    RuntimeAttr default_attr = object {
        cpu_cores:          2,
        mem_gb:             4,
        disk_gb:            disk_size,
        boot_disk_gb:       10,
        preemptible_tries:  1,
        max_retries:        1,
        docker:             "dbest/samtools:v1.21"
    }
    RuntimeAttr runtime_attr = select_first([runtime_attr_override, default_attr])
    runtime {
        cpu:                    select_first([runtime_attr.cpu_cores,         default_attr.cpu_cores])
        memory:                 select_first([runtime_attr.mem_gb,            default_attr.mem_gb]) + " GiB"
        disks: "local-disk " +  select_first([runtime_attr.disk_gb,           default_attr.disk_gb]) + " SSD"
        bootDiskSizeGb:         select_first([runtime_attr.boot_disk_gb,      default_attr.boot_disk_gb])
        preemptible:            select_first([runtime_attr.preemptible_tries, default_attr.preemptible_tries])
        maxRetries:             select_first([runtime_attr.max_retries,       default_attr.max_retries])
        docker:                 select_first([runtime_attr.docker,            default_attr.docker])
    }
}

task Dict {
    meta {
        description : "samtools dict a fasta file."
    }

    parameter_meta {
        reference: "Reference fasta file for which dictionary is to be created."
        runtime_attr_override: "Override the default runtime attributes."
    }

    input {
        File reference
        RuntimeAttr? runtime_attr_override
    }

    String outputFile = basename(reference)
    String reference_dict = sub(sub(outputFile,".fasta",".dict"),".fa",".dict")
    
    Int disk_size = 1 + 2*ceil(size(reference, "GB"))

    command <<<
        ln -s ~{reference} ~{outputFile}
    samtools dict -o ~{reference_dict} ~{outputFile}
    >>>

    output {
        File dict = reference_dict
    }

    RuntimeAttr default_attr = object {
        cpu_cores:          2,
        mem_gb:             4,
        disk_gb:            disk_size,
        boot_disk_gb:       10,
        preemptible_tries:  1,
        max_retries:        1,
        docker:             "dbest/samtools:v1.21"
    }
    RuntimeAttr runtime_attr = select_first([runtime_attr_override, default_attr])
    runtime {
        cpu:                    select_first([runtime_attr.cpu_cores,         default_attr.cpu_cores])
        memory:                 select_first([runtime_attr.mem_gb,            default_attr.mem_gb]) + " GiB"
        disks: "local-disk " +  select_first([runtime_attr.disk_gb,           default_attr.disk_gb]) + " SSD"
        bootDiskSizeGb:         select_first([runtime_attr.boot_disk_gb,      default_attr.boot_disk_gb])
        preemptible:            select_first([runtime_attr.preemptible_tries, default_attr.preemptible_tries])
        maxRetries:             select_first([runtime_attr.max_retries,       default_attr.max_retries])
        docker:                 select_first([runtime_attr.docker,            default_attr.docker])
    }
}

task Faidx {
    meta {
        description : "samtools faidx a fasta file."
    }

    parameter_meta {
        reference: "Reference fasta file for which dictionary is to be created."
        runtime_attr_override: "Override the default runtime attributes."
    }

    input {
        File reference
        RuntimeAttr? runtime_attr_override
    }

    String outputFile = basename(reference)
    String reference_fai = outputFile + ".fai"

    Int disk_size = 1 + 2*ceil(size(reference, "GB"))

    command <<<
        ln -s ~{reference} ~{outputFile}
        samtools faidx -o ~{reference_fai} ~{outputFile}
    >>>

    output {
        File fai = reference_fai
    }

    RuntimeAttr default_attr = object {
        cpu_cores:          2,
        mem_gb:             4,
        disk_gb:            disk_size,
        boot_disk_gb:       10,
        preemptible_tries:  1,
        max_retries:        1,
        docker:             "dbest/samtools:v1.21"
    }
    RuntimeAttr runtime_attr = select_first([runtime_attr_override, default_attr])
    runtime {
        cpu:                    select_first([runtime_attr.cpu_cores,         default_attr.cpu_cores])
        memory:                 select_first([runtime_attr.mem_gb,            default_attr.mem_gb]) + " GiB"
        disks: "local-disk " +  select_first([runtime_attr.disk_gb,           default_attr.disk_gb]) + " SSD"
        bootDiskSizeGb:         select_first([runtime_attr.boot_disk_gb,      default_attr.boot_disk_gb])
        preemptible:            select_first([runtime_attr.preemptible_tries, default_attr.preemptible_tries])
        maxRetries:             select_first([runtime_attr.max_retries,       default_attr.max_retries])
        docker:                 select_first([runtime_attr.docker,            default_attr.docker])
    }
}
