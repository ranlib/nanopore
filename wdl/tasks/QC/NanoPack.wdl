version 1.0

workflow NanoPack {
  
  meta {
    description: "QC for nanopore data using NanoQC and NanoPlot"
  }
  
  parameter_meta {
    # inputs
    inputFile: {description: "The input file.", category: "required"}
    outputDir: {description: "Output directory path.", category: "required"}
    directRna: {description: "Fastq is from direct RNA-seq and contains U nucleotides.", category: "common"}
    minLength: {description: "Filters the reads on a minimal length of the given range. Also plots the given length/2 of the begin and end of the reads.", category: "advanced"}
    memory: {description: "The amount of memory available to the job.", category: "advanced"}
    timeMinutes: {description: "The maximum amount of time the job will run in minutes.", category: "advanced"}
    dockerImage: {description: "The docker image used for this task. Changing this may result in errors which the developers may choose not to address.", category: "advanced"}
    
    # outputs
    report: {description: "Html summary report."}
    log: {description: "Progress report."}
  }
  
  input {
    # NanoQC
    File inputFile
    String outputDir
    Boolean directRna = false
    
    Int? minLength
    
    String memory = "2GiB"
    Int timeMinutes = 15
    String dockerImageNanoQC = "dbest/nanoqc:v0.9.4"

    # NanoPlot
    String inputFileType
    String outputPrefix
    String outputPath = outputDir + outputPrefix
    Boolean outputTsvStats = true
    Boolean dropOutliers = false
    Boolean logLengths = false
    String format = "png"
    Boolean showN50 = true
    String title = basename(outputPrefix)
    
    #Int? maxLength
    #Int? minLength
    #Int? minQual
    #String? readType
    
    Int threads = 2
    String dockerImageNanoPlot = "dbest/nanoplot:v1.42.0"
  }
  
  # call NanoQC {
  #   input:
  #   inputFile = inputFile,
  #   outputDir = outputDir,
  #   directRna = directRna,
  #   minLength = minLength,
  #   memory = memory,
  #   timeMinutes = timeMinutes,
  #   dockerImage = dockerImage
  # }

  call NanoPlot {
    input:
        inputFile = inputFile,
        inputFileType = inputFileType,
        outputDir = outputDir,
        outputPrefix = outputPrefix,
        outputTsvStats = outputTsvStats,
        dropOutliers = dropOutliers,
        logLengths = logLengths,
        format = format,
        showN50 = showN50,
        title = title,
        threads = threads,
        memory = memory,
        timeMinutes = timeMinutes,
        dockerImage = dockerImageNanoPlot
    }

  output {
    #File report = NanoQC.report
    #File log = NanoQC.log
    File? dynamicHistogram = NanoPlot.dynamicHistogram
    File? readLengthHistogram = NanoPlot.readLengthHistogram
    File? logScaleReadLengthHistogram = NanoPlot.logScaleReadLengthHistogram
    File report = NanoPlot.report
    File weightedHistogram = NanoPlot.weightedHistogram
    File weightedLogScaleHistogram = NanoPlot.weightedLogScaleHistogram 
    File yieldByLength = NanoPlot.yieldByLength
    File? lengthVsQualityScatterPlotDot = NanoPlot.lengthVsQualityScatterPlotDot
    File? lengthVsQualityScatterPlotKde = NanoPlot.lengthVsQualityScatterPlotKde
    File stats = NanoPlot.stats
  }
}

task NanoQC {
    input {
        File inputFile
        String outputDir
        Boolean directRna = false

        Int? minLength

        String memory = "2GiB"
        Int timeMinutes = 15
        String dockerImage = "dbest/nanoqc:v0.9.4"
    }

    command {
        set -e
        mkdir -p "$(dirname ~{outputDir})"
        nanoQC \
        --outdir ~{outputDir} \
        ~{true="--rna" false="" directRna} \
        ~{"--minlen " + minLength} \
        ~{inputFile}
    }

    output {
        File report = outputDir + "nanoQC.html"
        File log = outputDir + "NanoQC.log"
    }

    runtime {
        memory: memory
        docker: dockerImage
    }

    parameter_meta {
        # inputs
        inputFile: {description: "The input file.", category: "required"}
        outputDir: {description: "Output directory path.", category: "required"}
        directRna: {description: "Fastq is from direct RNA-seq and contains U nucleotides.", category: "common"}
        minLength: {description: "Filters the reads on a minimal length of the given range. Also plots the given length/2 of the begin and end of the reads.", category: "advanced"}
        memory: {description: "The amount of memory available to the job.", category: "advanced"}
        timeMinutes: {description: "The maximum amount of time the job will run in minutes.", category: "advanced"}
        dockerImage: {description: "The docker image used for this task. Changing this may result in errors which the developers may choose not to address.", category: "advanced"}

        # outputs
        report: {description: "Html summary report."}
        log: {description: "Progress report."}
    }
}

task NanoPlot {
    input {
        File inputFile
        String inputFileType
        String outputDir
        String outputPrefix
        String outputPath = outputDir + outputPrefix
        Boolean outputTsvStats = true
        Boolean dropOutliers = false
        Boolean logLengths = false
        String format = "png"
        Boolean showN50 = true
        String title = basename(outputPrefix)

        Int? maxLength
        Int? minLength
        Int? minQual
        String? readType

        Int threads = 2
        String memory = "2GiB"
        Int timeMinutes = 15
        String dockerImage = "dbest/nanoplot:v1.42.0"
    }

    Map[String, String] fileTypeOptions = {"fastq": "--fastq ", "fasta": "--fasta ", "fastq_rich": "--fastq_rich ", "fastq_minimal": "--fastq_minimal ", "summary": "--summary ", "bam": "--bam ", "ubam": "--ubam ", "cram": "--cram ", "pickle": "--pickle ", "feather": "--feather "}

    command {
        set -ex
        mkdir -p "$(dirname ~{outputPath})"
        NanoPlot \
        --threads ~{threads} \
        --outdir ~{outputDir} \
        --prefix ~{outputPrefix} \
        ~{true="--tsv_stats" false="" outputTsvStats} \
        ~{true="--drop_outliers" false="" dropOutliers} \
        ~{true="--loglength" false="" logLengths} \
        --format ~{format} \
        ~{true="--N50" false="--no-N50" showN50} \
        ~{"--maxlength " + maxLength} \
        ~{"--minlength " + minLength} \
        ~{"--minqual " + minQual} \
        ~{"--readtype " + readType} \
        ~{fileTypeOptions[inputFileType] + inputFile}
    }

    output {
        File? dynamicHistogram = outputDir + outputPrefix + "Dynamic_Histogram_Read_length.html"
        File? readLengthHistogram = outputDir + outputPrefix + "HistogramReadlength.png"
        File? logScaleReadLengthHistogram = outputDir + outputPrefix + "LogTransformed_HistogramReadlength.png"
        File report = outputDir + outputPrefix + "NanoPlot-report.html"
        File weightedHistogram = outputDir + outputPrefix + "WeightedHistogramReadlength.png"
        File weightedLogScaleHistogram = outputDir + outputPrefix + "WeightedLogTransformed_HistogramReadlength.png"
        File yieldByLength = outputDir + outputPrefix + "Yield_By_Length.png"
        File? lengthVsQualityScatterPlotDot = outputDir + outputPrefix + "LengthvsQualityScatterPlot_dot.png"
        File? lengthVsQualityScatterPlotKde = outputDir + outputPrefix + "LengthvsQualityScatterPlot_kde.png"
        File stats = outputDir + outputPrefix + "NanoStats.txt"
    }

    runtime {
        cpu: threads
        memory: memory
        docker: dockerImage
    }

    parameter_meta {
        # inputs
        inputFile: {description: "The input file.", category: "required"}
        inputFileType: {description: "The format of the read file.", category: "required"}
        outputDir: {description: "Output directory path.", category: "required"}
        outputPrefix: {description: "Output file prefix.", category: "required"}
        outputPath: {description: "Combination of the outputDir & outputPrefix strings.", category: "advanced"}
        outputTsvStats: {description: "Output the stats file as a properly formatted TSV.", category: "common"}
        dropOutliers: {description: "Drop outlier reads with extreme long length.", category: "advanced"}
        logLengths: {description: "Additionally show logarithmic scaling of lengths in plots.", category: "advanced"}
        format: {description: "Specify the output format of the plots.", category: "required"}
        showN50: {description: "Show the N50 mark in the read length histogram.", category: "common"}
        title: {description: "Add a title to all plots, requires quoting if using spaces.", category: "common"}
        maxLength: {description: "Hide reads longer than length specified.", category: "advanced"}
        minLength: {description: "Hide reads shorter than length specified.", category: "advanced"}
        minQual: {description: "Drop reads with an average quality lower than specified.", category: "advanced"}
        readType: {description: "Which read type to extract information about from summary. Options are 1D, 2D, 1D2", category: "advanced"}
        threads: {description: "The number of threads to be used.", category: "advanced"}
        memory: {description: "The amount of memory available to the job.", category: "advanced"}
        timeMinutes: {description: "The maximum amount of time the job will run in minutes.", category: "advanced"}
        dockerImage: {description: "The docker image used for this task. Changing this may result in errors which the developers may choose not to address.", category: "advanced"}

        # outputs
        dynamicHistogram: {description: "Dynamic histogram of read length."}
        readLengthHistogram: {description: "Histogram of read length."}
        logScaleReadLengthHistogram: {description: "Histogram of read lengths after log transformation."}
        report: {description: "Html summary report."}
        weightedHistogram: {description: "Weighted histogram of read lengths."}
        weightedLogScaleHistogram: {description: "Weighted histogram of read lengths after log transformation."}
        yieldByLength: {description: "Cumulative yield plot."}
        lengthVsQualityScatterPlotDot: {description: "Read lengths vs average read quality plot."}
        lengthVsQualityScatterPlotKde: {description: "Read lengths vs average read quality plot."}
        stats: {description: "NanoStats report."}
    }
}

