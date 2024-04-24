version 1.0

task CirclatorAll {
    input {
        Array[String] options
        Array[String] required_arguments
    }

    command {
        circlator all ${options} ${required_arguments}
    }

    runtime {
        docker: "sangerpathogens/circlator:latest"
    }
}


task CirclatorMapReads {
    input {
        Array[String] options
        Array[String] required_arguments
    }

    command {
        circlator mapreads ${options} ${required_arguments}
    }

    runtime {
        docker: "sangerpathogens/circlator:latest"
    }
}

task CirclatorBam2Reads {
    input {
        Array[String] options
        Array[String] required_arguments
    }

    command {
        circlator bam2reads ${options} ${required_arguments}
    }

    runtime {
        docker: "sangerpathogens/circlator:latest"
    }
}

task CirclatorAssemble {
    input {
        Array[String] options
        Array[String] required_arguments
    }

    command {
        circlator assemble ${options} ${required_arguments}
    }

    runtime {
        docker: "sangerpathogens/circlator:latest"
    }
}

task CirclatorMerge {
    input {
        Array[String] options
        Array[String] required_arguments
    }

    command {
        circlator merge ${options} ${required_arguments}
    }

    runtime {
        docker: "sangerpathogens/circlator:latest"
    }
}

task CirclatorClean {
    input {
        Array[String] options
        Array[String] required_arguments
    }

    command {
        circlator clean ${options} ${required_arguments}
    }

    runtime {
        docker: "sangerpathogens/circlator:latest"
    }
}

task CirclatorFixStart {
    input {
        Array[String] options
        Array[String] required_arguments
    }

    command {
        circlator fixstart ${options} ${required_arguments}
    }

    runtime {
        docker: "sangerpathogens/circlator:latest"
    }
}

task CirclatorMinimus2 {
    input {
        Array[String] options
        Array[String] required_arguments
    }

    command {
        circlator minimus2 ${options} ${required_arguments}
    }

    runtime {
        docker: "sangerpathogens/circlator:latest"
    }
}

task CirclatorGetDnaA {
    input {
        Array[String] options
        Array[String] required_arguments
    }

    command {
        circlator get_dnaa ${options} ${required_arguments}
    }

    runtime {
        docker: "sangerpathogens/circlator:latest"
    }
}

task CirclatorProgCheck {
    input {
        Array[String] options
        Array[String] required_arguments
    }

    command {
        circlator progcheck ${options} ${required_arguments}
    }

    runtime {
        docker: "sangerpathogens/circlator:latest"
    }
}

task CirclatorTest {
    input {
        Array[String] options
        Array[String] required_arguments
    }

    command {
        circlator test ${options} ${required_arguments}
    }

    runtime {
        docker: "sangerpathogens/circlator:latest"
    }
}

task CirclatorVersion {
    input {
        Array[String] options
        Array[String] required_arguments
    }

    command {
        circlator version ${options} ${required_arguments}
    }

    runtime {
        docker: "sangerpathogens/circlator:latest"
    }
}

# Workflow
workflow CirclatorWorkflow {
    input {
        String command
        Array[String] options
        Array[String] required_arguments
    }

    scatter (opt in options) {
        call task_map[opt] {
            input:
                options = [opt],
                required_arguments = required_arguments
        }
    }
}
