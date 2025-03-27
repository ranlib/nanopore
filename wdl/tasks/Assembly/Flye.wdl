version 1.0

task Flye {
    input {
        Array[File]+ reads  # Input read files (FASTA/FASTQ format, can be gzipped)
        String read_type  # One of: "--pacbio-raw", "--pacbio-corr", "--pacbio-hifi", "--nano-raw", "--nano-corr", "--nano-hq"
        String output_dir  # Path to output directory
        String genome_size  # Estimated genome size (e.g., "5m", "2.6g")
        Int threads = 1  # Number of threads
        Int iterations = 1  # Number of polishing iterations
        Int? min_overlap  # Minimum overlap between reads (optional)
        Int? asm_coverage  # Reduced coverage for initial disjointig assembly (optional)
        Boolean metagenome = false  # Metagenome mode
        Boolean keep_haplotypes = false  # Keep alternative haplotypes
        Float? read_error  # Adjust parameters for read error rate
    }

    command <<<
      set -euxo pipefail
        flye \
        ~{read_type} ~{sep=" " reads} \
        --out-dir ~{output_dir} \
        --genome-size ~{genome_size} \
        --threads ~{threads} \
        --iterations ~{iterations} \
        ~{if defined(min_overlap) then "-m " + min_overlap else ""} \
        ~{if defined(asm_coverage) then "--asm-coverage " + asm_coverage else ""} \
        ~{if metagenome then "--meta" else ""} \
        ~{if keep_haplotypes then "--keep-haplotypes" else ""} \
        ~{if defined(read_error) then "--read-error " + read_error else ""}
    >>>

    output {
        Array[File] assembly_files = glob("~{output_dir}/*")
    }

    runtime {
        docker: "dbest/flye:v2.9.5"
        cpu: threads
        memory: "16G"
    }
}

workflow FlyeWorkflow {
  meta {
    description: "Assemble a genome using Flye"
  }
  
  parameter_meta {
    reads: "Input reads (in fasta or fastq format, compressed or uncompressed)"
    read_type: "Read type for running flye"
    output_dir: "Name of output directory"
  }

    input {
        Array[File]+ reads  # Input read files
        String read_type  # Read type flag
        String output_dir  # Output directory
        String genome_size  # Estimated genome size
        Int threads = 1  # Number of threads
        Int iterations = 1  # Number of polishing iterations
        Int? min_overlap  # Minimum overlap between reads
        Int? asm_coverage  # Reduced coverage for initial disjointig assembly
        Boolean metagenome = false  # Metagenome mode
        Boolean keep_haplotypes = false  # Keep alternative haplotypes
        Float? read_error  # Read error rate adjustment
    }

    call Flye {
        input:
            reads=reads,
            read_type=read_type,
            output_dir=output_dir,
            genome_size=genome_size,
            threads=threads,
            iterations=iterations,
            min_overlap=min_overlap,
            asm_coverage=asm_coverage,
            metagenome=metagenome,
            keep_haplotypes=keep_haplotypes,
            read_error=read_error
    }

    output {
        Array[File] assembly_files = Flye.assembly_files
    }
}
