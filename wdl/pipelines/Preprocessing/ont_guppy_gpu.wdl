version 1.0

import "../../structs/Structs.wdl"

workflow ont_guppy_gpu {
  input {
    String basecall_config
    String? barcode_kit
    Array[File]+ fast5_files
  }

  call guppy_basecall_gpu {
    input:
    fast5_files = fast5_files,
    basecall_config = basecall_config,
    barcode_kit = barcode_kit
  }
  
  output {
    Array[File] pass_fastqs = guppy_basecall_gpu.pass_fastqs
    File sequencing_summary = guppy_basecall_gpu.sequencing_summary
    Array[String] barcodes = guppy_basecall_gpu.barcodes
    Map[String, String] metadata = guppy_basecall_gpu.metadata
    Int num_pass_fastqs = guppy_basecall_gpu.num_pass_fastqs
    Int num_fail_fastqs = guppy_basecall_gpu.num_fail_fastqs
  }
}


task guppy_basecall_gpu {
  input {
    String basecall_config
    String? barcode_kit
    Array[File]+ fast5_files
    Int index = 0
    RuntimeAttr? runtime_attr_override
  }


  Int disk_size_gb = 3 * ceil(size(fast5_files, "GB"))
  String barcode_arg = if defined(barcode_kit) then "--barcode_kits \"~{barcode_kit}\" --enable_trim_barcodes" else ""
  
  command <<<
    set -xe
    mkdir -p ./fast5_dir
    for FILE in ~{sep=" " fast5_files} ; do
       cp ${FILE} ./fast5_dir
    done
    guppy_basecaller -i ./fast5_dir/ -s guppy_output -c ~{basecall_config} ~{barcode_arg} -x "cuda:all" --num_callers 14 --gpu_runners_per_device 8 --compress_fastq

    # Make a list of the barcodes that were seen in the data
    find guppy_output/ -name '*fastq*' -not -path '*fail*' -type f | \
    awk -F"/" '{ a=NF-1; a=$a; gsub(/pass/, "unclassified", a); print a }' | \
    sort -n | \
    uniq | tee barcodes.txt
    
    # Reorganize and rename the passing filter data to include the barcode in the filename
    mkdir pass
    find guppy_output/ -name '*fastq*' -not -path '*fail*' -type f | \
    awk -F"/" '{ a=NF-1; a=$a; b=$NF; gsub(/pass/, "unclassified", a); c=$NF; for (i = NF-1; i > 0; i--) { c=$i"/"c }; system("mv " c " pass/" a ".chunk_~{index}." b); }'
    
    # Reorganize and rename the failing filter data to include the barcode in the filename
    mkdir fail
    find guppy_output/ -name '*fastq*' -not -path '*pass*' -type f | \
    awk -F"/" '{ a=NF-1; a=$a; b=$NF; gsub(/pass/, "unclassified", a); c=$NF; for (i = NF-1; i > 0; i--) { c=$i"/"c }; system("mv " c " fail/" a ".chunk_~{index}." b); }'
    
    # Count passing and failing files
    find pass -name '*fastq.gz' | wc -l | tee num_pass.txt
    find fail -name '*fastq.gz' | wc -l | tee num_fail.txt
    
    # Extract relevant metadata (e.g. sample id, run id, etc.) from the first fastq file
    find pass -name '*fastq.gz' -type f | \
    head -1 | \
    xargs -n1 zgrep -m1 '^@' | \
    sed 's/ /\n/g' | \
    grep -v '^@' | \
    sed 's/=/\t/g' | \
    awk 'BEGIN{OFS="\t"}{ if ($1 == "sampleid" && $2 == "") {$2 = "unknown"} ; print $0 }' | tee metadata.txt
  >>>
  
  output {
    Array[File] pass_fastqs = glob("pass/*.fastq.gz")
    File sequencing_summary = "guppy_output/sequencing_summary.txt"
    Array[String] barcodes = read_lines("barcodes.txt")
    Map[String, String] metadata = read_map("metadata.txt")
    Int num_pass_fastqs = read_int("num_pass.txt")
    Int num_fail_fastqs = read_int("num_fail.txt")
  }

  RuntimeAttr default_attr = object {
    cpu_cores:          16,
    mem_gb:             64,
    disk_gb:            disk_size_gb,
    boot_disk_gb:       30,
    preemptible_tries:  1,
    max_retries:        1,
    docker:             "genomicpariscentre/guppy-gpu:latest"
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
    gpuType:                "nvidia-tesla-p100"
    gpuCount:               1
    nvidiaDriverVersion:    "418.152.00"
    zones:                  ["us-central1-c", "us-central1-f", "us-east1-b", "us-east1-c", "us-west1-a", "us-west1-b"]
    cpuPlatform:            "Intel Haswell"
  }
}
