# List of resources
## CWL (Common Workflow Language)
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
* [CWL Viewer: draw out workflows from a CWL file](https://view.commonwl.org/)
## Geospatial
* [OGC Best Practice for Earth Observation Application Package](https://docs.ogc.org/bp/20-089r1.html#toc0)
  * [Best practice examples](https://github.com/eoap)
* [Terradue EO Application Package walk-through](https://terradue.github.io/ogc-eo-application-package-hands-on/)
  * [Tutorial files](https://github.com/Terradue/ogc-eo-application-package-hands-on)
* [CWL for EO](https://cwl-for-eo.github.io/guide/) **WARNING**: errors in code samples



# CWL Details
See [https://www.commonwl.org/v1.1/CommandLineTool.html](https://www.commonwl.org/v1.1/CommandLineTool.html

## Definitions

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

Optional _requirement_ values for a _Workflow_ include:
* InlineJavascriptRequirement
* SchemaDefRequirement
* LoadListingRequirement
* DockerRequirement
* SoftwareRequirement
* InitialWorkDirRequirement
* EnvVarRequirement
* ShellCommandRequirement
* ResourceRequirement
* WorkReuse
* NetworkAccess
* InplaceUpdateRequirement
* ToolTimeLimit
* SubworkflowFeatureRequirement
* ScatterFeatureRequirement
* MultipleInputFeatureRequirement
* StepInputExpressionRequirement

Requirements override hints. A hint is similar to a requirement but does not error if it cannot be satisfied.

An _expression_ is a fragment of Javascript evaluated by the _Workflow_ platform to affect the inputs, outputs, or behavior of a process. Expressions in CWL are an optional feature and are not required to be implemented by all consumers of CWL documents. They should be used sparingly, when there is no other way to achieve the desired outcome. To declare the use of expressions, the document must include the process requirement InlineJavascriptRequirement. 

## Execution
### Set up
With reference to [https://cwl-for-eo.github.io/guide/requirements/](https://cwl-for-eo.github.io/guide/requirements/) the following requirements are recommended:

* **A CWL runner**: CWL is a set of open standards for describing computational workflows. These workflows are executed using a CWL runner and there are several implementations of such runners. For local testing `cwltool` is recommended. Follow the installation steps listed o the referenced website above and test the CWL runner installation with `cwltool --help` which needs to return the path to the executable.
* **A container runner**: the default set up is to use Docker. check with your platform administrators as to what system is used, but for local testing 'cwltool' supports running containers with [Docker](https://www.docker.com/), [Podman](https://podman.io/), [udocker](https://indigo-dc.github.io/udocker/) and [Singularity](https://docs.sylabs.io/guides/3.5/user-guide/introduction.html).


### Execution sequence
The generic execution sequence of a CWL process (including Workflows and CommandLineTools) is as follows.

* Load input object.
* Load, process and validate a CWL document. The $namespaces present in the CWL document are also used when validating and processing the input object.
* If there are multiple process objects (due to $graph) then choose the process with the id of "#main" or "main".
* Validate the input object against the inputs schema for the process.
* Perform any further setup required by the specific process type.
* Execute the process.
* Capture results of process execution into the output object.
* Validate the output object against the outputs schema for the process.
* Report the output object to the process caller.


## Scripting workflows
### Why CWL?
While shell scripts or other code scripts (e.g. Python) can meet the need of data processing workflows, using a formal workflow language (such as CWL) brings additional benefits such as abstraction and improved scalability and portability. 

Computational workflows explicitly create a divide between a user’s dataflow and the computational details which underpin the chain of tools. 

The dataflow is described by the workflow and the tool implementation is specified by descriptors that remove the workflow complexity.

Workflow managers such as `cwltool` help with the automation, monitoring and tracking of a dataflow. By producing computational workflows in a standardised format, and publishing them (alongside any data) with open access, the workflows become more FAIR (Findable, Accessible, Interoperable, and Reusable). The Common Workflow Language (CWL) standard has been developed to standardise workflow needs across different thematic areas.

### Basic CWL 

As suggested by [https://docs.dockstore.org/en/develop/getting-started/getting-started-with-cwl.html](https://docs.dockstore.org/en/develop/getting-started/getting-started-with-cwl.html) it is recommended to have the following non-essential fields:

```
doc: <description>  # Description of the CWl file
id: <id>            # The unique identifier for this object
label: <label>      # A short, human-readable label of this object

cwlVersion: <version>
```

A simple first CWL script could be (echo.cwl):

```
cwlVersion: v1.2
class: CommandLineTool

doc: A ComandLineTool file to echo some text
id: "EchoTool"
label: "EchoTool"

baseCommand: echo

inputs:
  message_text:
    type: string
    inputBinding:
      position: 1

outputs: []
```
used with echo-text.yml:
```
message_text: Hello world!
```
and run using `cwltool echo.cwl echo-text.yml`. The output would be some program-gennerated text on the status of the workflow steps as well as _Hello World!_

In CWL, outputs need to be explcitly defined so that the workflow runner knows which files are to be saved and which are temporary. An `outputBinding` section in the `outputs` section describes how to determine the required output (often requiring a `glob` command). The following code snippet connects the `myoutputfile` parameter to `output.csv` which is defined as a `File`.

```
<additional CWL code...>
outputs:
  myoutputfile:
    type: File
    outputBinding:
      glob: output.csv
```
### Useful syntax

```
type: File        # Single file
type: File[]      # List of files
type: Directory   # Specifies a folder class

# reference output from a specific step
outputSource:
    - <step-name>/<data-name>
```
See [here](https://www.commonwl.org/v1.2/Workflow.html#CWLType) for more data types.

### Less basic CWL
A "packed" CWL file references multiple process objects within it, rather than referencing out to individual CWL files. Therefore, it becomes possible to store and transmit a Workflow together with the processes of each of its steps using only one file.

An entire process object can be "embedded" into the run field of a workflow step. If the step process is a subworkflow, it can be processed recursively to embed the processes of the subworkflow steps.

Alternatively, a `$graph` field lists process objects, where each must have an `id` field. These are cross-referenced using the id of the process object within the workflow file. Typically packed CWL documents contain a Workflow called “main” and the workflow steps under that. If there is no #main object, the an error will occur.

An example of a `$graph` structure is shown here:
```
cwlVersion: v1.1

$graph:
- class: CommandLineTool
  id:
  requirements: [] 
  baseCommand: []
  arguments: []
  inputs: {}
  outputs: {}
```
# Containers
Containers solve the need for dependencies between software required to run specific commands. Containers are described by an image file (a template), where the container itself is an instantiation of the image.

ToDo: Add info