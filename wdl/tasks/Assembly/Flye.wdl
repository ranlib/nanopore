version 1.0

workflow Flye {

    meta {
        description: "Assemble a genome using Flye"
    }
    parameter_meta {
        genome_size: "Estimated genome size in base pairs"
        reads: "Input reads (in fasta or fastq format, compressed or uncompressed)"
        prefix: "Prefix to apply to assembly output filenames"
    }

    input {
        File reads
        Float genome_size
        String prefix
    }

    call Assemble {
        input:
            reads  = reads,
            prefix = prefix
    }

    output {
        File gfa = Assemble.gfa
        File fa = Assemble.fa
    }
}

task Assemble {
    input {
        File reads
        String prefix = "out"
    }

    parameter_meta {
        reads:    "reads (in fasta or fastq format, compressed or uncompressed)"
        prefix:   "prefix to apply to assembly output filenames"
    }

    Int disk_size = 10 * ceil(size(reads, "GB"))

    command <<<
        set -euxo pipefail

        num_core=$(cat /proc/cpuinfo | awk '/^processor/{print $3}' | wc -l)

        flye --nano-raw ~{reads} --threads $num_core --out-dir asm

        mv asm/assembly.fasta ~{prefix}.flye.fa
        mv asm/assembly_graph.gfa ~{prefix}.flye.gfa
    >>>

    output {
        File gfa = "~{prefix}.flye.gfa"
        File fa = "~{prefix}.flye.fa"
    }

    runtime {
        cpu: 1
        memory: "10GB"
        disks: "local-disk " + disk_size + " HDD"
        preemptible: 1
        maxRetries: 1
        docker: "dbest/flye:v2.9.3"
    }
}
