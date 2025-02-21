version 1.0

workflow ont_dorado {
  
  input {
    String sample_id
    File fast5_archive
    String basecall_model
  }
  
  call Basecall {
    input:	
    sample_id = sample_id,
    fast5_archive = fast5_archive,
    basecall_model = basecall_model
  }

  call makefastqs {
    input:
    sample_id = sample_id,
    unmapped_bam = Basecall.unmapped_bam
  }

  output {
    File unmapped_bam = Basecall.unmapped_bam
    File fastq = makefastqs.fastq
  }
}

task Basecall  {
  input {
    String sample_id
    File fast5_archive
    String basecall_model
    Int disk_gb = ceil(size(fast5_archive, "GB")*3) + 5
  }
  
  command <<<
    
    if [[ ~{fast5_archive} == *.pod5 ]]; then
     mkdir pod5s
     ln -s ~{fast5_archive} pod5s/reads.pod5
    fi

    # Simplex call with --emit-moves
    dorado basecaller --emit-moves /models/~{basecall_model} pod5s | samtools view -Sh > ~{sample_id}.unmapped.bam

  >>>

  runtime {
    gpuType: "nvidia-tesla-v100"
    gpuCount: 1
    cpu: 12
    disks: "local-disk " + disk_gb + " SSD" 
    memory: "64GB"
    nvidiaDriverVersion: "470.161.03"
    zones: ["us-central1-a"] 
    docker: "ontresearch/dorado"
  }

  output {
    File unmapped_bam = "~{sample_id}.unmapped.bam"
  }
}

task makefastqs {
  input {
    String sample_id  
    File unmapped_bam
  }
  
  command <<<
    samtools fastq -T "*" ~{unmapped_bam} | gzip > ~{sample_id}.fastq.gz
  >>>
  
  output {
    File fastq = "~{sample_id}.fastq.gz"
  }
  
  runtime {
    docker: "dbest/samtools:v1.21"
    memory: "64G"
    disks: "local-disk 500 SSD"
    cpu: 8
  }
}
