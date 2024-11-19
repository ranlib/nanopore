version 1.0

workflow GenomeSimulator {
    input {
        File ref_genome
        String? model_prefix = "training"
        String output_prefix = "simulated"
        Int? number_of_reads = 20000
        Int? max_length
        Int? min_length = 50
        Int? median_length
        Float? standard_deviation
        Int? seed
        Int? kmer_bias
        String? basecaller
        Float? strandness
        String dna_type = "linear"
        Boolean perfect = false
        Boolean fastq = false
        Boolean chimeric = false
        Int num_threads = 1
    }

    call SimulateReads {
        input:
            ref_genome = ref_genome,
            model_prefix = model_prefix,
            output_prefix = output_prefix,
            number_of_reads = number_of_reads,
            max_length = max_length,
            min_length = min_length,
            median_length = median_length,
            standard_deviation = standard_deviation,
            seed = seed,
            kmer_bias = kmer_bias,
            basecaller = basecaller,
            strandness = strandness,
            dna_type = dna_type,
            perfect = perfect,
            fastq = fastq,
            chimeric = chimeric,
            num_threads = num_threads
    }

    output {
        File simulated_reads = SimulateReads.simulated_reads
    }
}

task SimulateReads {
    input {
        File ref_genome
        String? model_prefix
        String output_prefix
        Int? number_of_reads
        Int? max_length
        Int? min_length
        Int? median_length
        Float? standard_deviation
        Int? seed
        Int? kmer_bias
        String? basecaller
        Float? strandness
        String dna_type
        Boolean perfect
        Boolean fastq
        Boolean chimeric
        Int num_threads
        String docker = "dbest/nanosim:v3.2.2"
    }

    command <<<
        simulator.py genome \
            -rg ~{ref_genome} \
            ~{if defined(model_prefix) then "-c " + model_prefix else ""} \
            -o ~{output_prefix} \
            ~{if defined(number_of_reads) then "-n " + number_of_reads else ""} \
            ~{if defined(max_length) then "-max " + max_length else ""} \
            ~{if defined(min_length) then "-min " + min_length else ""} \
            ~{if defined(median_length) then "-med " + median_length else ""} \
            ~{if defined(standard_deviation) then "-sd " + standard_deviation else ""} \
            ~{if defined(seed) then "--seed " + seed else ""} \
            ~{if defined(kmer_bias) then "-k " + kmer_bias else ""} \
            ~{if defined(basecaller) then "-b " + basecaller else ""} \
            ~{if defined(strandness) then "-s " + strandness else ""} \
            -dna_type ~{dna_type} \
            ~{if perfect then "--perfect" else ""} \
            ~{if fastq then "--fastq" else ""} \
            ~{if chimeric then "--chimeric" else ""} \
            -t ~{num_threads}
    >>>

    output {
        File simulated_reads = "~{output_prefix}.fastq" # if fastq else "~{output_prefix}.fasta"
    }

    runtime {
      docker: docker
      cpu: num_threads
      memory: "4G"
    }

    meta {
        description: "Simulate reads from a reference genome using simulator.py."
    }

    parameter_meta {
        ref_genome: {
            description: "Input reference genome file."
        }
        model_prefix: {
            description: "Location and prefix of error profiles generated from the characterization step."
        }
        output_prefix: {
            description: "Output location and prefix for simulated reads."
        }
        number_of_reads: {
            description: "Number of reads to simulate."
        }
        max_length: {
            description: "Maximum length for simulated reads."
        }
        min_length: {
            description: "Minimum length for simulated reads."
        }
        median_length: {
            description: "Median read length. Not compatible with chimeric reads."
        }
        standard_deviation: {
            description: "Standard deviation of read length in log scale. Not compatible with chimeric reads."
        }
        seed: {
            description: "Seed for the pseudo-random number generator."
        }
        kmer_bias: {
            description: "Minimum homopolymer length for simulating contraction and expansion events."
        }
        basecaller: {
            description: "Simulate reads with respect to a chosen basecaller (e.g., albacore, guppy)."
        }
        strandness: {
            description: "Proportion of sense sequences (between 0 and 1)."
        }
        dna_type: {
            description: "Specify the DNA type: linear or circular."
        }
        perfect: {
            description: "Ignore error profiles and simulate perfect reads."
        }
        fastq: {
            description: "Output reads in FASTQ format instead of FASTA."
        }
        chimeric: {
            description: "Simulate chimeric reads."
        }
        num_threads: {
            description: "Number of threads to use for the simulation."
        }
    }
}
