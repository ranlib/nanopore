version 1.0

workflow run_pypolca {
    # Define input parameters
    input {
        File assembly
        File reads1
        File? reads2
        Int threads = 1
        String output_dir = "output_pypolca"
        Boolean force = false
        Int min_alt = 2
        Float min_ratio = 2.0
        Boolean careful = false
        Boolean no_polish = false
        String memory_limit = "2G"
        String prefix = "pypolca"
    }

    # Call the task
    call pypolca_task {
        input:
            assembly=assembly,
            reads1=reads1,
            reads2=reads2,
            threads=threads,
            output_dir=output_dir,
            force=force,
            min_alt=min_alt,
            min_ratio=min_ratio,
            careful=careful,
            no_polish=no_polish,
            memory_limit=memory_limit,
            prefix=prefix
    }

    # Output files from the task
    output {
        Array[File] output_files = pypolca_task.output_files
    }
}

task pypolca_task {
    # Define input parameters for the task
    input {
        File assembly
        File reads1
        File? reads2
        Int threads
        String output_dir
        Boolean force
        Int min_alt
        Float min_ratio
        Boolean careful
        Boolean no_polish
        String memory_limit
        String prefix
    }

    # Define command to be executed
    command {
        pypolca run \
            --assembly ${assembly} \
            --reads1 ${reads1} \
            ${if defined(reads2) then "--reads2 " + reads2 else ""} \
            --threads ${threads} \
            --output ${output_dir} \
            ${if force then "--force" else ""} \
            --min_alt ${min_alt} \
            --min_ratio ${min_ratio} \
            ${if careful then "--careful" else ""} \
            ${if no_polish then "--no_polish" else ""} \
            --memory_limit ${memory_limit} \
            --prefix ${prefix}
    }

    # Specify the Docker container to use
    runtime {
        docker: "dbest/polca:v0.3.1"
        memory: "${memory_limit}"
        cpu: threads
    }

    # Define the output files to be collected
    output {
        Array[File] output_files = glob("${output_dir}/*")
    }
}
