# Using Flow-IQ
Flow-IQ is a toolkit designed to help NIH researchers migrate and adapt their Nextflow-based pipelines—especially those relying on nf-core modules—from Biowulf HPC cluster to the AWS cloud.

This guide is organized into two main sections:
1. **Getting Started: Migrating to the Cloud** – How to use Flow-IQ to migrate an existing pipeline.
2. **Custom Pipeline Developement:** How to go from an nf-core module to a custom pipeline, run it on Biowulf, and then deploy it on AWS HealthOmics.


## Before You Start: What You Should Know
If you’re new to any of the core technologies used in Flow-IQ, here are some helpful resources:

   - **Nextflow:** [Nextflow](https://nextflow.io/docs/latest/index.html) A workflow system for creating scalable, portable, and reproducible workflows. Consider taking the Nextflow [training tutorial](https://training.nextflow.io/2.0/) to get up to speed.
   - **nf-core:** A community effort to collect a curated set of analysis pipelines built with Nextflow. Also see ["What is nf-core?"](https://nf-co.re/docs/usage/getting_started/introduction).
   - **Linters:** Tools that check code for errors or non-compliance with standards. Also see this [Wikipedia article](https://en.wikipedia.org/wiki/Lint_(software)) on linting.
   - **Containers:** Bundles your app and its dependencies so it runs the same everywhere. Also see the [Docker Container Guide](https://docs.docker.com/get-started/workshop/).
   
<br><br>



# 🚀 Getting Started: Migrating to the Cloud
   
Before migrating your pipeline to the cloud, check the following to ensure it meets basic cloud-readiness criteria:
- Uses **cloud-accessible paths** for input/output data (e.g., `s3://` instead of local or Biowulf file paths)
- Tools are executed within **containers** (e.g., Docker or Apptainer).
- Specifies **`cpus`** and **`memory`** for each process
- Use a **cloud-compatible executor** in your config (e.g., aws-batch)

<br>



## Adapt Your Pipeline For Cloud
Use the [FlowIQ website](https://nci-dceg.github.io/Flow-IQ/) to begin adapting your workflow for the cloud:

1. **Swap Biowulf Modules for Containers**<br> – Use the Docker Image Builder to find container equivalents for Biowulf environment modules and update your script accordingly.
1. **Update Data Paths**<br> – Use the Example Data Builder to locate cloud-hosted datasets (e.g., iGenomes on AWS).

## Validate your Workflow: Two-phase linting
Ensure your pipeline is cloud-ready and follows best practices using a two-phase linting approach.

### Phase 1 – Lightweight Cloud Linter
Use our [custom script](https://github.com/NCI-DCEG/Flow-IQ/tree/main/scripts) to run `linter-rules-for-nextflow` Docker container (converts to Apptainer).

This quick-check tool validates:
- Syntax (e.g., cpus, memory, container directives)
- Cloud readiness for [AWS HealthOmics](https://aws.amazon.com/healthomics/)
   
### Phase 2 – nf-core/tools Linter
For a more comprehensive check, run the [`nf-core/tools` lint](https://nf-co.re/docs/guidelines/pipelines/requirements/linting). This is especially usefule if you plan to **share, publish, or contribute** your pipeline. The nf-core community have put together amazing docs for [Getting Started with nf-core](https://nf-co.re/docs/usage/getting_started/introduction) that we encourage you to view.

<details>
  <summary>Expand for `nf-core/tools lint` details</summary>

<br>

**Why use nf-core/tools?**
The `nf-core` initiative promotes standardized, reproducible pipelines for the bioinformatics community. The linting tool checks your pipeline against [core requirements](https://nf-co.re/docs/guidelines/pipelines/overview) and highlights areas for improvement.

* Ensures your pipeline adheres to community best practices
* Verifies metadata, naming conventions, documentation, and structure
* Flags both required and [recommended](https://nf-co.re/docs/guidelines/pipelines/overview#recommendations) improvements

If your goal is collaboration or publication, using this tool is highly recommended.

</details>

---

<br><br>




# 🧱 Custom Pipeline Development
This section covers how to build a custom pipeline using an nf-core module, run it on Biowulf HPC, and adapt it for AWS HealthOmics with Flow-IQ.

### Example:
If you’re using the nf-core **[Sarek](https://nf-co.re/sarek/3.5.1/)** pipeline but only need the **[Manta germline](https://nf-co.re/modules/manta_germline/)** module, we'll show you how to extract it and build a standalone workflow. Then you will learn how to make it ready to run on AWS HealthOmics.

## What is an nf-core?

## What is an nf-core module?

## How to use an nf-core module for your custom pipeline?

## How to test on Biowulf

## How to prepare pipeline for AWS HealthOmics

## Deploying on AWS HealthOmics

## Troubleshooting / Tips

