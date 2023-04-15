version 1.0

import "../tasks/HelloTask.wdl" as Hello
import "../../long-read-pipelines/wdl/tasks/Utility/Utils.wdl"

workflow HelloWorkflow {
    meta {
        description: "Example workflow."
    }

    parameter_meta {
        greeting: "The message to print"
    }

    input {
        String greeting
    }

    # Run a task locally defined in this repo
    call Hello.Print { input: message = greeting }

    # Run a task remotely defined in the long-read-pipelines repo
    call Utils.Sum { input: ints = [1, 2, 3] }

    output {
        String message = Hello.text
        Int sum = Sum.sum
    }
}
