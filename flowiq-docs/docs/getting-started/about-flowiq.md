# About Flow-IQ

**Flow-IQ** is a toolkit designed to help researchers transition bioinformatics workflows from traditional HPC environments like Biowulf to the AWS cloud.

<br>

### Key Features

* An [interactive toolkit](../explorer/index.md) for mapping Biowulf environment modules to matching Docker images, along with curated links to cloud-accessible datasets (e.g., AWS Open Data equivalents of Biowulf iGenomes).
* Guides and demos on using `nf-core/tools` and custom linters to verify that pipelines are cloud-ready.
* Step-by-step instructions for building custom pipelines from nf-core modules that run on both HPC and AWS environments.

<br>

## How It's Organized

The [User Guide](../user-guide/index.md) walks you through each step of building a custom Nextflow pipeline using nf-core modules. You'll learn how to assemble your pipeline, make it portable, and prepare it for cloud deployment using linters and the [Flow-IQ Explorer](../explorer/index.md) to locate compatible data and containers.

<br>

---

This resource was developed by <a href="https://dceg.cancer.gov/about/organization/tdrp/wong-wendy">Wendy Wong</a>, a bioinformatician
at the <a href="https://dceg.cancer.gov/">National Cancer Institute - Division of Cancer Epidemiology & Genetics</a>, and Jesse Marks, a bioinformatics software engineer at <a href="https://rti.org">RTI International - GenOmics and Translational Research Center.</a>

