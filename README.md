# Flow-IQ Quick Reference Guide

1. **What is FlowIQ?**
   
   **FlowIQ** is a toolkit designed to help NIH researchers migrate their Nextflow bioinformatics workflows from Biowulf to the cloud.
  Key features include:
      - A [searchable website](https://nci-dceg.github.io/Flow-IQ/) to find Docker images matching Biowulf environment modules, along with curated links to cloud-accessible datasets and references (e.g., mapping Biowulf iGenomes data to s3://ngi-igenomes/ on AWS Open Data).
      - Guides and GIFs on using a custom linter developed with AWS, as well as the `nf-core/tools` linter, to help ensure your Nextflow pipeline is syntactically correct and cloud-ready.
  
<br>


2. **Who is This Toolkit For?**

   - NIH researchers who rely on the Biowulf HPC cluster for their bioinformatics analyses using standard tools, custom scripts, or Nextflow-based workflows.
   - This toolkit assumes you are working with Nextflow workflow scripts and running analyses on the Biowulf HPC cluster.

<br>


3. **Before You Start: What You Should Know**

   - **New to Nextflow?** [Nextflow](https://nextflow.io/docs/latest/index.html) is a workflow system for creating scalable, portable, and reproducible workflows. Consider taking the Nextflow [training tutorial](https://training.nextflow.io/2.0/) to get up to speed.
   - **New to nf-core?** nf-core is a community effort to collect a curated set of analysis pipelines built with Nextflow. Also see ["What is nf-core?"](https://nf-co.re/docs/usage/getting_started/introduction).

   - **New to linters?** Linters automatically check your code or workflows for errors and best practices. Also see this [Wikipedia article](https://en.wikipedia.org/wiki/Lint_(software)) on linting.
   - **New to containers?** A container bundles your app and its dependencies so it runs the same everywhere. Also see the [Docker Container Guide](https://docs.docker.com/get-started/workshop/).
   
<br>


4. **Getting Started**

   * Installation / setup steps (or link to them)
   * First steps with FlowIQ
<br>


5. **Next Steps**

   * Recommended workflow
   * Advanced use cases
<br>


6. **What is a Linter (and Why Use One)?**

   * Simple explanation
   * How FlowIQ uses linting to improve pipeline quality
<br>


7. **Additional Resources**

   * Official documentation
   * Tutorials, blogs, or videos
<br>


8. **Need Help?**

   * How to report issues (e.g. GitHub Issues)
   * Contact or community support info
