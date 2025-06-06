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
This section walks you through how to build a custom pipeline using an nf-core module, test it on the Biowulf HPC, and adapt it for AWS HealthOmics with Flow-IQ.

We'll follow a real-world example and explain each step, focusing on what needs to happen and why.


## Example Scenario

Suppose you’re working with the nf-core **[Sarek](https://nf-co.re/sarek/3.5.1/)** pipeline and then have an idea for an analysis using one step of the pipeline.
In particular, you want to build a custom pipeline for your analysis using the **[Manta germline](https://nf-co.re/modules/manta_germline/)** module. 

This guide will show you how to:
- Extract and reuse the module
- Build a minimal pipeline around it
- Test it locally (e.g., on Biowulf HPC)
- Prepare and deploy it to AWS HealthOmics using Flow-IQ

## Step 1: Locate the Module

Let’s say you’ve seen Manta used within the Sarek pipeline and want to use the manta_germline module in a standalone workflow.
You’re not modifying Sarek—you’re building something new, based on a reusable module.


<p float="left">
  <img src="assets/nfcore-sarek.png" width="45%" />
  <img src="assets/nfcore-manta-germline.png" width="45%" />
</p>



## Step 2: Understand How nf-core Modules Work

While it might seem like you can just run:
```bash
nf-core modules install manta/germline
```
...it's not quite that simple.
nf-core modules are reusable building blocks–not pipelines. You need a proper Nextflow pipeline project to plug the module into.
Without this, you'll run into errors because modules can't run on their own.
They need a pipeline "framework" to run within else you will get an error like you see below.

<p float="left">
  <img src="assets/nfcore-modules-install-error.png" />
</p>


So let's move on to the next step and see what we need to do first.

<br>

## Step 3: Create a pipeline

We’ll use the nf-core tool to scaffold a new custom pipeline.


<p float="left">
  <img src="assets/nfcore-command.png" height="350" />
  <img src="assets/nfcore-pipelines-command.png" height="350" />
</p>

<br>

You’ll be walked through an interactive prompt to fill in:
- Basic info (name, description)
- Default template features (we’ll use the defaults)
- Location for the new pipeline
- Optional GitHub repo (you can skip this for now and add one later)



<p align="left">
   <img src="assets/demo-nfcore-pipeline-create.gif", width="75%" />
</p>

<br>


## Step 4: Install the Manta Module

Inside your new pipeline folder, run:
```
nf-core modules install manta/germline
```

This will add the module to your project and update your `modules.json`.

<p align="left">
   <img src="assets/demo-manta.gif", width="75%" />
</p>


 > 💡 **Notice at the end of the GIF:** it shows how to include the module in your workflow using the following line:

```
include { MANTA_GERMLINE } from `../modules/nf-core/manta/germline/main`
```

Now let's build a simple pipeline using this Manta module.

<br>


<!--
<video width="300" height="200" src="https://github.com/user-attachments/assets/f3edf923-4df8-4345-8513-95dc07ba978c"></video>

<p float="left">
  <img src="assets/demo_manta.gif" width="45%" />
  <img src="assets/demo_manta.gif" width="45%" />
</p>

<table>
  <tr>
    <td><img src="assets/nfcore_command.png" width="45%"/></td>
    <td><img src="assets/nfcore_pipelines_command.png" width="45%"/></td>
  </tr>
</table>
-->



## Step 5: Build a One-Step Workflow

When you enter the pipeline directory you created, you’ll notice several files and directories generated by nf-core.
<p float="left"> <img src="assets/nci-dceg-ls-output.png" width="45%" /> </p>

For now, we’ll focus on `main.nf`, the core Nextflow script where we will integrate the `Manta` module into our custom pipeline.

### Understanding `main.nf`

The first few lines of `main.nf` should look something like this:
```
#!/usr/bin/env nextflow
/*  
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    nci-dceg/flowiq
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Github : https://github.com/nci-dceg/flowiq
----------------------------------------------------------------------------------------
*/      
    
/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    IMPORT FUNCTIONS / MODULES / SUBWORKFLOWS / WORKFLOWS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/  
        
include { FLOWIQ  } from './workflows/flowiq'
include { PIPELINE_INITIALISATION } from './subworkflows/local/utils_nfcore_flowiq_pipeline'
include { PIPELINE_COMPLETION     } from './subworkflows/local/utils_nfcore_flowiq_pipeline'
include { getGenomeAttribute      } from './subworkflows/local/utils_nfcore_flowiq_pipeline'
```

Locate the section labeled `IMPORT FUNCTIONS / MODULES / SUBWORKFLOWS / WORKFLOWS`.
Here is where you'll add the `include` statement for the Manta module you installed in Step 4.
Add it directly below the existing include lines.
This statement allows the pipeline to reference the module located in the `modules/` directory at the root of your project.

<br><br>

### Understanding `nextflow.config`

Let’s now explore the configuration file at the root of your pipeline: `nextflow.config`.

This file does a few important things:
* Sets pipeline-wide configuration parameters
* Defines default values used throughout the workflow
* Includes references to additional config files (like `conf/igenomes.config`)

For example, you might see the following line in the `params` block in `nextflow.config`:
`igenomes_base = 's3://ngi-igenomes/igenome'`
This line specifies the base path for AWS-hosted reference genome files.

**How is this used?**

In `main.nf`, you may see a line like:
`params.fasta = getGenomeAttribute('fasta')`

This line uses a function–`getGenomeAttribute`—that was automatically included earlier in the script.
It dynamically constructs the path to the appropriate reference file based on the selected genome build.

So, for instance, if `params.genome = 'GRCh37'`, the FASTA file path would resolve to:
`s3://ngi-igenomes/igenomes/Homo_sapiens/Ensembl/GRCh37/Sequence/WholeGenomeFasta/genome.fa`

You can verify this logic by checking the contents of `conf/igenomes.config`

Which we can see that it's also supported by the Flow-IQ toolkit:
<p float="left">
  <img src="assets/flowiq-sync-command-builder.png" width="45%" />
</p>




<!-- 
Add instructions for including this in the `main.nf` script and also what to put in the `nextflow.config`
-->


<br><br>

### Understanding requirements for `Manta`

To understand how to run the Manta module, navigate to the nf-core module page:<br>
🔗 https://nf-co.re/modules/manta_germline/

There you’ll find:
- A module description
- Input/output channel definitions
- Parameter requirements
- A link to the source code on GitHub

The corresponding GitHub repo can be found here:<br>
🔗 https://github.com/nf-core/modules/tree/master/modules/nf-core/manta/germline


Everything defined on the module webpage is backed by the module's `meta.yml` file: `modules/nf-core/manta/germline/meta.yml`
> 💡 Tip: At the bottom of each nf-core module page, there are links to additional, in-depth documentation for that module.


So now let's take a look back at the inputs/outputs required by `Manta` and see what we need to modify in the `main.nf` and also in the `nextflow.config` file.
From the webpage for `Manta`
🔗  https://nf-co.re/modules/manta_germline/

we can see that there 4 blocks of inputs required and some are grouped under named variables like meta, meta2, and meta3. which are used to bundle related values together.

So let's look at each input block.
1. BAM/CRAM/SAM files + their indexes
* These are the aligned sequencing reads (e.g., BAM or CRAM files) that Manta will analyze.
* Each input alignment file (like .bam) must have a corresponding index file (.bai for BAM, .crai for CRAM).
* For joint calling, you can pass in multiple files.

2. Target regions (optional, used for exomes or targeted panels)
* A BED file tells Manta to limit variant calling to specific genomic regions (like exons).
* The .bed.tbi is its index, which allows quick access.

3. Reference genome: FASTA file + index
* `meta2` groups this reference input.
* The FASTA file is the reference genome. And remember that the generated `main.nf` had a section for this which we will use.
* `meta3` groups the FASTA index file (.fai).

4. Optional config file
* Allows you to override or extend Manta settings with a custom config file


### ❓ What Do I Need to Run Manta?

To successfully run the Manta module, you’ll need the following input files:

#### ✅ **Required**

* One `.bam` or `.cram` file per sample **with** its corresponding `.bai` or `.crai` index.
* A reference genome in `.fa` format **along with** its `.fa.fai` index.

#### 🟡 **Optional**

* A BED file (`.bed.gz`) for targeted calling, plus its `.tbi` index.
* A custom Manta configuration file.

---

### 📁 Where Do I Get Example Input Files?

The best place to start is by looking at the file:

```
modules/nf-core/manta/germline/tests/main.nf.test
```

Each `nf-core` module includes this file, which defines how to test the module using small example datasets from the `nf-core/test-datasets` repository:

🔗 [https://github.com/nf-core/test-datasets](https://github.com/nf-core/test-datasets)

You can also find a detailed guide for using this data here:

🔗 [https://github.com/nf-core/test-datasets/blob/master/docs/USE\_EXISTING\_DATA.md](https://github.com/nf-core/test-datasets/blob/master/docs/USE_EXISTING_DATA.md)

---

### 🧪 About the Test Datasets

The `test-datasets` repository includes a special `modules` branch:

> This branch of the `nf-core/test-datasets` repository contains all data used for the individual module tests.

That’s what we’ll use to test our Manta module.

---

### 🔍 What Does `main.nf.test` Expect?

If you open `main.nf.test`, you'll notice it references inputs like this:

```nextflow
file(params.modules_testdata_base_path + 'genomics/homo_sapiens/illumina/cram/test.paired_end.sorted.cram', checkIfExists: true)
```

This means we need to define the base path `params.modules_testdata_base_path` in a configuration file.

---

### ⚙️ Setting Up `modules_testdata_base_path`

Rather than editing the main `nextflow.config`, it's cleaner to add this to the testing profile.

In `nextflow.config`, you’ll find a profile named `test`:

```nextflow
test {
  includeConfig 'conf/test.config'
}
```

Edit the `conf/test.config` file and add the following:

```nextflow
// Input data
// nf-core: Specify the paths to your test data from the test-datasets repo
modules_testdata_base_path = 'https://raw.githubusercontent.com/nf-core/test-datasets/modules/data/'
```

This uses the GitHub raw URL so Nextflow can directly access the files.

---

### ✅ Running the Module Test

Once your config is set, you can run the test using the `nf-test` tool (a simple framework for testing Nextflow pipelines and modules):

```bash
nf-core modules test manta/germline --profile conda,test
```

---

<p float="left">
  <img src="assets/demo-nf-test-manta-module.gif" width="45%" />
</p>


Ok, so now we have seen how we can test our `Manta` module using some nf-core test data.
Now we have learned about what the required inputs and where some example test datasets are and how to use the Nextflow configuration files.
So let's now use this knowledge we have learned to help us create our own pipeline by modifing our `main.nf` script.

<!--
  Now you’ve got a minimal pipeline that runs the module in isolation.
-->

<br><br>
<br><br>
<br><br>
<br><br>

## Step 6: Test on Biowulf HPC

Run your new pipeline on Biowulf to ensure it works in your local environment.
This helps catch basic runtime issues before migrating to the cloud.


<br>

## Step 7: Prepare for AWS HealthOmics

Now that your pipeline works locally, it’s time to prepare it for the cloud:
- Use Flow-IQ tools to check for cloud-readiness
- Validate using the lightweight and nf-core/tools linters

<br>

## Step 8: Deploy to AWS HealthOmics

With validation complete, you’re ready to deploy:
- Upload your pipeline
- Set your input parameters and environment
- Launch your job on AWS HealthOmics


<br><br><br><br>

# ⚙️ Troubleshooting & Tips
## Seqera AI: Bioinformatics Agent for Nextflow
Seqera is the company behind Nextflow.
They have built an Bioinformatics AI agent trained specifically for Nextflow.
You can use this to accelerate your workflow building and reduce the time you spend troubleshooting so you can spend less time on the undifferentiated work and more time crafting your bioinformatics pipeline.

Here are the steps to using it:
1. Visit [**Ask-AI**](https://seqera.io/ask-ai/chat) by Seqera.
2. Sign in using your GitHub or Google account.

   > 💡 You can also try the [**Nextflow VS Code Extension**](https://marketplace.visualstudio.com/items?itemName=nextflow.nextflow) for inline AI support while coding.
3. Type a question or paste a prompt into the input bar to get help instantly.


<p float="left">
  <img src="assets/demo-seqera-ai.gif" width="75%" />
</p>
