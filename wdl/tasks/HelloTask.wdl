version 1.0

task HelloTask {
    input {
        String message
    }

    command <<<
        set -euxo pipefail

        python -c "print(~{sep="+" ints})" > ~{prefix}.txt
    >>>

    output {
        Int sum = read_int("~{prefix}.txt")
        File sum_file = "~{prefix}.txt"
    }

    runtime {
        cpu:            1
        memory:         10 + " GiB"
        disks:          "local-disk " + 10 + " HDD"
        bootDiskSizeGb: 10
        preemptible:    2
        maxRetries:     1
        docker:         "us.gcr.io/broad-dsp-lrma/lr-align:0.1.28"
    }
}