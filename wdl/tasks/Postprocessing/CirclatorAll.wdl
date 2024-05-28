version 1.0

workflow wf_circlator {
    # Define input parameters
    input {
        File assembly_fasta
        File reads_fastq
        String output_directory
        Int threads = 1
        Boolean verbose = false
        Int unchanged_code = 0
        String assembler = "spades"
        Boolean split_all_reads = false
        String data_type = "pacbio-corrected"
        String assemble_spades_k = "127,117,107,97,87,77"
        Boolean assemble_spades_use_first = false
        Boolean assemble_not_careful = false
        Boolean assemble_not_only_assembler = false
        String bwa_opts = "-x pacbio"
        Boolean b2r_discard_unmapped = false
        File? b2r_only_contigs
        Int b2r_length_cutoff = 100000
        Int b2r_min_read_length = 250
        Int merge_diagdiff = 25
        Float merge_min_id = 95.0
        Int merge_min_length = 500
        Int merge_min_length_merge = 4000
        Float merge_min_spades_circ_pc = 95.0
        Int merge_breaklen = 500
        Int merge_ref_end = 15000
        Int merge_reassemble_end = 1000
        Boolean no_pair_merge = false
        Int clean_min_contig_length = 2000
        Int clean_min_contig_percent = 95
        Int clean_diagdiff = 25
        Float clean_min_nucmer_id = 95.0
        Int clean_min_nucmer_length = 500
        Int clean_breaklen = 500
        File? genes_fa
        Int? fixstart_mincluster
        Float fixstart_min_id = 70.0
    }

    # Call the task
    call task_circlator {
        input:
            assembly_fasta=assembly_fasta,
            reads_fastq=reads_fastq,
            output_directory=output_directory,
            threads=threads,
            verbose=verbose,
            unchanged_code=unchanged_code,
            assembler=assembler,
            split_all_reads=split_all_reads,
            data_type=data_type,
            assemble_spades_k=assemble_spades_k,
            assemble_spades_use_first=assemble_spades_use_first,
            assemble_not_careful=assemble_not_careful,
            assemble_not_only_assembler=assemble_not_only_assembler,
            bwa_opts=bwa_opts,
            b2r_discard_unmapped=b2r_discard_unmapped,
            b2r_only_contigs=b2r_only_contigs,
            b2r_length_cutoff=b2r_length_cutoff,
            b2r_min_read_length=b2r_min_read_length,
            merge_diagdiff=merge_diagdiff,
            merge_min_id=merge_min_id,
            merge_min_length=merge_min_length,
            merge_min_length_merge=merge_min_length_merge,
            merge_min_spades_circ_pc=merge_min_spades_circ_pc,
            merge_breaklen=merge_breaklen,
            merge_ref_end=merge_ref_end,
            merge_reassemble_end=merge_reassemble_end,
            no_pair_merge=no_pair_merge,
            clean_min_contig_length=clean_min_contig_length,
            clean_min_contig_percent=clean_min_contig_percent,
            clean_diagdiff=clean_diagdiff,
            clean_min_nucmer_id=clean_min_nucmer_id,
            clean_min_nucmer_length=clean_min_nucmer_length,
            clean_breaklen=clean_breaklen,
            genes_fa=genes_fa,
            fixstart_mincluster=fixstart_mincluster,
            fixstart_min_id=fixstart_min_id
    }

    # Output files from the task
    output {
        Array[File] output_files = task_circlator.output_files
    }
}

task task_circlator {
    # Define input parameters for the task
    input {
        File assembly_fasta
        File reads_fastq
        String output_directory
        Int threads
        Boolean verbose
        Int unchanged_code
        String assembler
        Boolean split_all_reads
        String data_type
        String assemble_spades_k
        Boolean assemble_spades_use_first
        Boolean assemble_not_careful
        Boolean assemble_not_only_assembler
        String bwa_opts
        Boolean b2r_discard_unmapped
        File? b2r_only_contigs
        Int b2r_length_cutoff
        Int b2r_min_read_length
        Int merge_diagdiff
        Float merge_min_id
        Int merge_min_length
        Int merge_min_length_merge
        Float merge_min_spades_circ_pc
        Int merge_breaklen
        Int merge_ref_end
        Int merge_reassemble_end
        Boolean no_pair_merge
        Int clean_min_contig_length
        Int clean_min_contig_percent
        Int clean_diagdiff
        Float clean_min_nucmer_id
        Int clean_min_nucmer_length
        Int clean_breaklen
        File? genes_fa
        Int? fixstart_mincluster
        Float fixstart_min_id
    }

    # Define command to be executed
    command {
        circlator all \
            ${assembly_fasta} \
            ${reads_fastq} \
            ${output_directory} \
            --threads ${threads} \
            ${if verbose then "--verbose" else ""} \
            --unchanged_code ${unchanged_code} \
            --assembler ${assembler} \
            ${if split_all_reads then "--split_all_reads" else ""} \
            --data_type ${data_type} \
            --assemble_spades_k ${assemble_spades_k} \
            ${if assemble_spades_use_first then "--assemble_spades_use_first" else ""} \
            ${if assemble_not_careful then "--assemble_not_careful" else ""} \
            ${if assemble_not_only_assembler then "--assemble_not_only_assembler" else ""} \
            --bwa_opts "${bwa_opts}" \
            ${if b2r_discard_unmapped then "--b2r_discard_unmapped" else ""} \
            ${if defined(b2r_only_contigs) then "--b2r_only_contigs " + b2r_only_contigs else ""} \
            --b2r_length_cutoff ${b2r_length_cutoff} \
            --b2r_min_read_length ${b2r_min_read_length} \
            --merge_diagdiff ${merge_diagdiff} \
            --merge_min_id ${merge_min_id} \
            --merge_min_length ${merge_min_length} \
            --merge_min_length_merge ${merge_min_length_merge} \
            --merge_min_spades_circ_pc ${merge_min_spades_circ_pc} \
            --merge_breaklen ${merge_breaklen} \
            --merge_ref_end ${merge_ref_end} \
            --merge_reassemble_end ${merge_reassemble_end} \
            ${if no_pair_merge then "--no_pair_merge" else ""} \
            --clean_min_contig_length ${clean_min_contig_length} \
            --clean_min_contig_percent ${clean_min_contig_percent} \
            --clean_diagdiff ${clean_diagdiff} \
            --clean_min_nucmer_id ${clean_min_nucmer_id} \
            --clean_min_nucmer_length ${clean_min_nucmer_length} \
            --clean_breaklen ${clean_breaklen} \
            ${if defined(genes_fa) then "--genes_fa " + genes_fa else ""} \
            ${if defined(fixstart_mincluster) then "--fixstart_mincluster " + fixstart_mincluster else ""} \
            --fixstart_min_id ${fixstart_min_id}
    }

    # Specify the Docker container to use
    runtime {
        docker: "sangerpathogens/circlator:latest"
        memory: "16G"
        cpu: threads
    }

    # Define the output files to be collected
    output {
        Array[File] output_files = glob("${output_directory}/*")
    }
}
