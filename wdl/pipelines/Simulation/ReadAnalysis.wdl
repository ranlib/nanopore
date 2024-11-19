version 1.0

workflow ReadAnalysis {
    input {
        File read_file
        File? reference_genome
        String? aligner = "minimap2"
        File? genome_alignment
        String output_prefix = "training"
        Boolean detect_chimeric = false
        Boolean analyze_homopolymer = false
        Int? min_homopolymer_length = 5
        Boolean analyze_fastq = false
        Boolean disable_model_fit = false
        Int num_threads = 1
    }

    call AnalyzeReads {
        input:
            read_file = read_file,
            reference_genome = reference_genome,
            aligner = aligner,
            genome_alignment = genome_alignment,
            output_prefix = output_prefix,
            detect_chimeric = detect_chimeric,
            analyze_homopolymer = analyze_homopolymer,
            min_homopolymer_length = min_homopolymer_length,
            analyze_fastq = analyze_fastq,
            disable_model_fit = disable_model_fit,
            num_threads = num_threads
    }

    output {
        File profiles = AnalyzeReads.profiles
    }
}

task AnalyzeReads {
    input {
        File read_file
        File? reference_genome
        String? aligner
        File? genome_alignment
        String output_prefix
        Boolean detect_chimeric
        Boolean analyze_homopolymer
        Int? min_homopolymer_length
        Boolean analyze_fastq
        Boolean disable_model_fit
        Int num_threads
        String docker = "dbest/nanosim:v3.2.2"
    }

    command <<<
        read_analysis.py genome \
            -i ~{read_file} \
            ~{if defined(reference_genome) then "-rg " + reference_genome else ""} \
            ~{if defined(aligner) then "-a " + aligner else ""} \
            ~{if defined(genome_alignment) then "-ga " + genome_alignment else ""} \
            -o ~{output_prefix} \
            ~{if detect_chimeric then "-c" else ""} \
            ~{if analyze_homopolymer then "-hp" else ""} \
            ~{if defined(min_homopolymer_length) then "--min_homopolymer_len " + min_homopolymer_length else ""} \
            ~{if analyze_fastq then "--fastq" else ""} \
            ~{if disable_model_fit then "--no_model_fit" else ""} \
            -t ~{num_threads}
    >>>

    output {
        File profiles = "~{output_prefix}.profile"
    }

    runtime {
      cpu: num_threads
      memory: "4G"
      docker: docker
    }

    meta {
        description: "Analyze a read file using read_analysis.py to generate profiles for genome alignment and homopolymer lengths."
    }

    parameter_meta {
        read_file: {
            description: "Input read file for analysis."
        }
        reference_genome: {
            description: "Optional reference genome file. Not required if a genome alignment file is provided."
        }
        aligner: {
            description: "The aligner to use for genome alignment (minimap2 or LAST). Default is minimap2."
        }
        genome_alignment: {
            description: "Optional genome alignment file in SAM/BAM format."
        }
        output_prefix: {
            description: "Output location and prefix for generated profiles."
        }
        detect_chimeric: {
            description: "Detect chimeric and split reads (Default: false)."
        }
        analyze_homopolymer: {
            description: "Analyze homopolymer lengths (Default: false)."
        }
        min_homopolymer_length: {
            description: "Minimum length of homopolymers to analyze (Default: 5 bp)."
        }
        analyze_fastq: {
            description: "Analyze base qualities in FASTQ format (Default: false)."
        }
        disable_model_fit: {
            description: "Disable the model fitting step (Default: false)."
        }
        num_threads: {
            description: "Number of threads to use for alignment and model fitting (Default: 1)."
        }
    }
}
