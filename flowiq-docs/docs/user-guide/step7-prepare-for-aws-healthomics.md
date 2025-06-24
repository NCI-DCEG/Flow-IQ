# Step 7: Prepare for AWS HealthOmics

<br>

## Flow-IQ Explorer

[Flow-IQ](../explorer/index.md) is an interactive toolkit designed to help users transition from the Biowulf HPC environment to the cloud. It maps Biowulf environment modules to equivalent Docker images and includes curated links to cloud-accessible datasets (e.g., AWS Open Data equivalents of Biowulf iGenomes).

Here’s a short clip demonstrating how it works:

<p float="left">
  <img src="../assets/flowiq-explorer-demo.gif" width="100%" />
  <!--<img src="assets/flowiq-explorer-demo.gif" width="100%" />-->
</p>

<br> <br>

## Validate with Linters

To ensure that your Nextflow pipeline is cloud-ready and compatible with AWS HealthOmics, we use two linters:

| Tool                        | What It Checks                                                   | Why Use It                                                 |
| --------------------------- | ---------------------------------------------------------------- | ---------------------------------------------------------- |
| `linter-rules-for-nextflow` | Basic Nextflow syntax and AWS HealthOmics-specific requirements  | Fast, lightweight checks for syntax and compatibility      |
| `nf-core/tools`             | Conformance with nf-core guidelines and community best practices | Thorough checks to ensure reproducibility and shareability |

You can run both tools to validate your pipeline against key technical and community standards.

---


### `linter-rules-for-nextflow`

AWS originally developed an open-source tool called [linter-rules-for-nextflow](https://github.com/awslabs/linter-rules-for-nextflow/tree/main) to catch issues in Nextflow pipelines before runtime.
We’ve created a customized fork of this tool, added some rules tailored for NIH researchers transitioning from Biowulf to AWS HealthOmics, and developed a script so that the Docker version of this tool can be used in the Biowulf HPC environment.

To make it usable in HPC environments that support Apptainer (but not Docker), we provide a helper script:
**`docker_to_apptainer_nextflow_linter.sh`**
This script converts the [Docker image](https://hub.docker.com/r/jaamarks/linter-rules-for-nextflow) into an Apptainer-compatible format and runs the linter seamlessly in environments like Biowulf.

**Features:**

* Validates general Nextflow syntax
* Checks for AWS HealthOmics-specific requirements
* Verifies configuration files
* Provides clear violation messages with suggestions
* Runs without Docker via Apptainer
* Easy-to-follow tutorial and documentation available in the [`Flow-IQ/scripts`](https://github.com/NCI-DCEG/Flow-IQ/tree/main/scripts) folder

---

### `nf-core pipelines lint`

The `nf-core` project defines best-practice standards for building and sharing Nextflow pipelines.
The developed `nf-core/tools` Python package includes which includes a Nextflow linter which checks for syntax errors as well as comparing the pipeline structure against nf-core community guidelines.

**Why use it:**

* Enforces nf-core standards for reproducibility
* Helps prepare pipelines for broader sharing or publication
* Easy to install and run

**Resources:**

* Usage documentation: [nf-core tools lint](https://nf-co.re/docs/nf-core-tools/pipelines/lint)
* Full guidelines list: [nf-core pipeline guidelines](https://nf-co.re/docs/guidelines/pipelines/overview)

---

Using these tools prepares your pipeline for the next step: **[Deploy to AWS HealthOmics](step8-deploy-to-aws-healthomics.md)!** 🚀
