# List of resources
## CWL
* [CWL Official Getting Started pages](https://www.commonwl.org/user_guide/introduction/quick-start.html)
  * [CWL Introduction - official](https://www.commonwl.org/user_guide/introduction/index.html)
  * [Dockstore: getting started with CWL](https://docs.dockstore.org/en/develop/getting-started/getting-started-with-cwl.html)
  * [Arvados: CWL Introduction](https://doc.arvados.org/v2.7/user/cwl/rnaseq-cwl-training.html)
  * [Introduction to Workflows](https://carpentries-incubator.github.io/cwl-novice-tutorial/)
  * [Excellent walk-through tutorial](https://andrewjesaitis.com/posts/2017-02-06-cwl-tutorial/)
    * [Tutorial files](https://github.com/andrewjesaitis/cwl-tutorial)
* [CWL Specification: CommandLine Tool](https://www.commonwl.org/v1.1/CommandLineTool.html#CommandLineTool)
## Tools
* [ToolJig: create CWL files via a website](https://srp33.github.io/ToolJig/tool.html)
  * [Using ToolJig](https://elifesciences.org/articles/71069#abstract)
* [scriptcwl: Python package to create Workflows](https://github.com/NLeSC/scriptcwl)
* [cwl-utils: Python tools for loading / parsing CWL](https://github.com/common-workflow-language/cwl-utils)
## Geospatial
* [OGC Best Practice for Earth Observation Application Package](https://docs.ogc.org/bp/20-089r1.html#toc0)
  * [Best practice examples](https://github.com/eoap)
* [Terradue EO Application Package walk-through](https://terradue.github.io/ogc-eo-application-package-hands-on/)
  * [Tutorial files](https://github.com/Terradue/ogc-eo-application-package-hands-on)
* [CWL for EO](https://cwl-for-eo.github.io/guide/) **WARNING**: errors in code samples


# Details

## Definitions
See [https://www.commonwl.org/v1.1/CommandLineTool.html#CommandLineTool](https://www.commonwl.org/v1.1/CommandLineTool.html#CommandLineTool)

A _CommandLineTool_ is a process set by the execution of a standalone, non-interactive (command line) program which is (a) invoked on some input, (b) produces output, and then (c) terminates.

A _Workflow_ is a process set by multiple subprocess steps, where steps are individual _CommandLineTool_ files  and the _Workflow_ can be described as a [directed acyclic graph](https://en.wikipedia.org/wiki/Directed_acyclic_graph) where independent steps may run concurrently.

A _parameter_ is a named input of the _CommandLineTool_ or _Workflow_, ideally with an associated datatype or schema. During execution, values are assigned to parameters. Parameter references are denoted by the syntax $(...) 

A process _requirement_ modifies the runtime environment of a process. Requirements specified in a parent Workflow are inherited by each step if they are valid for that step. If the substep is a _CommandLineTool_ only the following requirements are valid: 
* InlineJavascriptRequirement
* SchemaDefRequirement
* DockerRequirement
* SoftwareRequirement
* InitialWorkDirRequirement
* EnvVarRequirement
* ShellCommandRequirement
* ResourceRequirement 

Requirements override hints. A hint is similar to a requirement but does not error if it cannot be satisfied.

An _expression_ is a fragment of Javascript evaluated by the _Workflow_ platform to affect the inputs, outputs, or behavior of a process. Expressions in CWL are an optional feature and are not required to be implemented by all consumers of CWL documents. They should be used sparingly, when there is no other way to achieve the desired outcome. To declare the use of expressions, the document must include the process requirement InlineJavascriptRequirement. 

## Execution

The generic execution sequence of a CWL process (including workflows and command line line tools) is as follows.

* Load input object.
* Load, process and validate a CWL document, yielding one or more process objects. The $namespaces present in the CWL document are also used when validating and processing the input object.
* If there are multiple process objects (due to $graph) and which process object to start with is not specified in the input object (via a cwl:tool entry) or by any other means (like a URL fragment) then choose the process with the id of "#main" or "main".
* Validate the input object against the inputs schema for the process.
* Validate process requirements are met.
* Perform any further setup required by the specific process type.
* Execute the process.
* Capture results of process execution into the output object.
* Validate the output object against the outputs schema for the process.
* Report the output object to the process caller.


By convention, a CWL document may begin with #!/usr/bin/env cwl-runner and be marked as executable (the POSIX "+x" permission bits) to enable it to be executed directly. A workflow platform may support this mode of operation; if so, it must provide cwl-runner as an alias for the platform's CWL implementation.



https://docs.dockstore.org/en/develop/getting-started/getting-started-with-cwl.html

It is recommended that you have the following minimum fields:

```
doc: <description>
id: <id>
label: <label>

cwlVersion: v1.1

dct:creator:
  foaf:name: <name>```


