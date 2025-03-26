version 1.0

task Hifiasm {
    input {
        Array[File] reads
        String output_prefix = "hifiasm.asm"
        Int threads = 1
        Boolean use_ont = false
    }

    command <<<
      set -euxo pipefail
      hifiasm \
      -o ~{output_prefix} \
      -t ~{threads} \
      ~{if use_ont then "--ont" else ""} \
      ~{sep=" " reads}
    >>>

    output {
        Array[File] assembly_files = glob("~{output_prefix}.*")
    }

    runtime {
        docker: "dbest/hifiasm:v0.25.0"
        cpu: threads
        memory: "8G"
    }
}


task gfa_to_fa {
  input { File gfa }

  String out = sub(basename(gfa),".gfa",".fa")

  command <<<
    set -euxo pipefail
    awk '/^S/{print ">"$2;print $3}' ~{gfa} > ~{out}
  >>>
  
  output { File fa = out }

  runtime {
    docker: "ubuntu:24.04"
  }
}


workflow Hifiasm_workflow {
    input {
        Array[File] reads
        String output_prefix = "hifiasm.asm"
        Int threads = 1
        Boolean use_ont = false
    }

    call Hifiasm {
        input:
            reads=reads,
            output_prefix=output_prefix,
            threads=threads,
            use_ont=use_ont
    }

    call gfa_to_fa {
      input:
      gfa = Hifiasm.assembly_files[0]
    }
    
    output {
      Array[File] assembly_files = Hifiasm.assembly_files
      File fasta = gfa_to_fa.fa
    }
}
