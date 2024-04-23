version 1.0

# Define inputs
task CirclatorMapReads {
    input {
        Array[String] options
        Array[String] required_arguments
    }

    command {
        circlator mapreads ${options} ${required_arguments}
    }

    runtime {
        docker: "dbest/circulator:v1.0"
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
        docker: "dbest/circulator:v1.0"
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
        docker: "dbest/circulator:v1.0"
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
        docker: "dbest/circulator:v1.0"
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
        docker: "dbest/circulator:v1.0"
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
        docker: "dbest/circulator:v1.0"
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
        docker: "dbest/circulator:v1.0"
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
        docker: "dbest/circulator:v1.0"
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
        docker: "dbest/circulator:v1.0"
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
        docker: "dbest/circulator:v1.0"
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
        docker: "dbest/circulator:v1.0"
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
