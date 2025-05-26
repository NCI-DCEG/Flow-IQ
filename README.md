# Flow-IQ Overview

<br>

## 1. What is Flow-IQ?

**Flow-IQ** is a toolkit designed to help NIH researchers migrate Nextflow bioinformatics workflows from the Biowulf HPC cluster to the cloud.
Key features include:

* A [searchable website](https://nci-dceg.github.io/Flow-IQ/) to find Docker images matching Biowulf environment modules, plus curated links to cloud-accessible datasets (e.g., mapping Biowulf iGenomes data to AWS Open Data).
* Guides and demos showing how to use custom and `nf-core/tools` linters to ensure pipelines are cloud-ready.
* Instructions for building custom pipelines from nf-core modules that run on both HPC and AWS.

<br>

## 2. Who is This Toolkit For?
NIH researchers who use Nextflow and nf-core pipelines on the Biowulf HPC cluster and are looking for guidance on building custom pipelines from nf-core modules and transitioning them to the cloud.

<br>

## 3. Where to Start?

See the `docs/` folder. The README guides you through creating a custom pipeline from an nf-core module and making it compatible with the cloud using Flow-IQ.

<br>

## 4. Need Help?

* **Report issues:** Use the Issues tab in this repo.
* **Contact:** Reach out to @jaamarks or @shukwong for support.
