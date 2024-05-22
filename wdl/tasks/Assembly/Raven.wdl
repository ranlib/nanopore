version 1.0

task run_raven {
    input {
        File sequences
        Int kmer_len = 15
        Int window_len = 5
        Float frequency = 0.001
        Float identity = 0.0
        Long kMaxNumOverlaps = 32
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
        Int threads = 1
    }

    command {
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
        --threads ~{threads} \
        ~{sequences}
    }

    output {
        File output_fasta = "output.fasta"
        File? graphical_fragment_assembly_file = graphical_fragment_assembly
        File? unitig_graphical_fragment_assembly_file = unitig_graphical_fragment_assembly
    }

    runtime {
        docker: "dbest/raven:v1.8.3"
        memory: "4G"
        cpu: threads
    }
}

workflow raven_workflow {
    input {
        File sequences
        Int kmer_len = 15
        Int window_len = 5
        Float frequency = 0.001
        Float identity = 0.0
        Long kMaxNumOverlaps = 32
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
        Int threads = 1
    }

    call run_raven {
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
            disable_checkpoints = disable_checkpoints,
            threads = threads
    }

    output {
        File output_fasta = run_raven.output_fasta
        File? graphical_fragment_assembly_file = run_raven.graphical_fragment_assembly_file
        File? unitig_graphical_fragment_assembly_file = run_raven.unitig_graphical_fragment_assembly_file
    }
}
