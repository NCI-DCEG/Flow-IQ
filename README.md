# Flow-IQ Quick Reference Guide

<br>

## 1. What is FlowIQ?
   
**FlowIQ** is a toolkit designed to help NIH researchers migrate their Nextflow bioinformatics workflows from Biowulf to the cloud.
Key features include:
- A [searchable website](https://nci-dceg.github.io/Flow-IQ/) to find Docker images matching Biowulf environment modules, along with curated links to cloud-accessible datasets and references (e.g., mapping Biowulf iGenomes data to s3://ngi-igenomes/ on AWS Open Data).
- Guides and GIFs on using a custom linter developed with AWS, as well as the `nf-core/tools` linter, to help ensure your Nextflow pipeline is syntactically correct and cloud-ready.
  
<br>



## 2. Who is This Toolkit For?
- NIH researchers who rely on the Biowulf HPC cluster for their bioinformatics analyses using standard tools, custom scripts, or Nextflow-based workflows.
- This toolkit assumes you are working with Nextflow workflow scripts and running analyses on the Biowulf HPC cluster.

<br>



## 3. Before You Start: What You Should Know

   - **New to Nextflow?** [Nextflow](https://nextflow.io/docs/latest/index.html) is a workflow system for creating scalable, portable, and reproducible workflows. Consider taking the Nextflow [training tutorial](https://training.nextflow.io/2.0/) to get up to speed.
   - **New to nf-core?** nf-core is a community effort to collect a curated set of analysis pipelines built with Nextflow. Also see ["What is nf-core?"](https://nf-co.re/docs/usage/getting_started/introduction).
   - **New to linters?** Linters automatically check your code or workflows for errors and best practices. Also see this [Wikipedia article](https://en.wikipedia.org/wiki/Lint_(software)) on linting.
   - **New to containers?** A container bundles your app and its dependencies so it runs the same everywhere. Also see the [Docker Container Guide](https://docs.docker.com/get-started/workshop/).
   
<br>



## 4. Getting Started
   
Before migrating your pipeline to the cloud, check the following to ensure it's on the right track: 
- Uses **cloud-accessible paths** for input/output data (e.g., `s3://` instead of local or Biowulf file paths)
- Tools are run inside **containers** (e.g., Docker).
- **`cpus`** and **`memory`** are explicitly specified for each process
- The `executor` in your config is set to a **cloud-compatible option** (e.g., aws-batch)

<br>



## 5. Migrating and Validating Your Workflow
After completing the "Getting Started" steps above, use the [FlowIQ website](https://nci-dceg.github.io/Flow-IQ/) to begin adapting your workflow for the cloud:

1. **Replace Biowulf modules with Docker containers**<br>
Use the Docker Image Builder to find containers matching Biowulf environment modules. Swap these into your Nextflow script to replace module load statements.
1. **Update data paths to cloud-hosted datasets**<br>
Use the Example Data Builder to find cloud-accessible versions of common datasets (e.g., iGenomes on AWS).
1. **Validate your workflow using a two-phase linting approach**<br>
Ensure compatibility and code quality before deployment:

### Phase 1 – Lightweight Cloud Linter
We created a [custom script](https://github.com/NCI-DCEG/Flow-IQ/tree/main/scripts) to facilitate running the `linter-rules-for-nextflow` Docker container (converts the Docker to Apptainer).
This page includes a README for the script with detailed instructions for how to use the tool for fast checks, including:
- Syntax validation (e.g., cpus, memory, container directives)
- Cloud-readiness for [AWS HealthOmics](https://aws.amazon.com/healthomics/)
   
### Phase 2 – nf-core/tools Linter
Use the [`nf-core/tools` pipeline lint](https://nf-co.re/docs/guidelines/pipelines/requirements/linting) for a comprehensive standards-based review. This step is especially valuable if you plan to **share, publish, or contribute** your pipeline to the community.

<details>
  <summary>Expand for `nf-core/tools pipeline lint` details</summary>

**Why use nf-core/tools?**
The `nf-core` initiative promotes standardized, reproducible pipelines for the bioinformatics community. The linting tool checks your pipeline against [core requirements](https://nf-co.re/docs/guidelines/pipelines/overview) and highlights areas for improvement.

* Ensures your pipeline adheres to community best practices
* Verifies metadata, naming conventions, documentation, and structure
* Flags both required and [recommended](https://nf-co.re/docs/guidelines/pipelines/overview#recommendations) improvements

If your goal is collaboration or publication, using this tool is highly recommended.

</details>


<br>


6. **Need Help?**

   * How to report issues (e.g. GitHub Issues)
   * Contact or community support info
