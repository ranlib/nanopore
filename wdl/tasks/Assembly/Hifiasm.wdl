version 1.0

task Hifiasm {
    input {
        Array[File] reads  # Input read files (FASTQ format)
        String output_prefix = "hifiasm.asm"  # Prefix for output files
        Int threads = 1  # Number of threads
        Boolean use_ont = false  # Whether to use Oxford Nanopore preset
    }

    command {
        hifiasm \
        -o ~{output_prefix} \
        -t ~{threads} \
        ~{if use_ont then "--ont" else ""} \
        ~{sep=" " reads}
    }

    output {
        Array[File] assembly_files = glob("~{output_prefix}.*")
    }

    runtime {
        docker: "dbest/hifiasm:v0.25.0"
        cpu: threads
        memory: "8G"
    }
}

workflow Hifiasm_workflow {
    input {
        Array[File] reads  # Input read files
        String output_prefix = "hifiasm.asm"  # Output file prefix
        Int threads = 1  # Number of threads
        Boolean use_ont = false  # Use Oxford Nanopore preset
    }

    call Hifiasm {
        input:
            reads=reads,
            output_prefix=output_prefix,
            threads=threads,
            use_ont=use_ont
    }

    output {
        Array[File] assembly_files = Hifiasm.assembly_files
    }
}
