# docker_to_apptainer_nextflow_linter.sh

`docker_to_apptainer_nextflow_linter.sh` is a Bash script designed to convert the [`linter-rules-for-nextflow`](https://hub.docker.com/r/jaamarks/linter-rules-for-nextflow) Docker image into an Apptainer-compatible format. This allows you to run a lightweight Nextflow linter Docker image in a High-Performance Computing (HPC) environment that supports Apptainer but not Docker.

### Prerequisites

To use this tool, you need to have Apptainer installed in your environment. The conversion process requires a minor modification, which this script automates for you.

### Features

The script can be executed on a Nextflow script or a configuration file. It performs several checks, including:

- Verifying that directive names are correct (e.g., memory, path).
- Ensuring that CPU specifications are provided.
- Applying rules to make the configuration AWS cloud-ready for the HealthOmics service, such as providing an appropriate container URI and ensuring the correct technical specifications for specs ratio.

<br>

## Usage

1. Log in to an interactive compute node and load Apptainer:

   ```bash
   $ sinteractive
   ```

2. Execute the Bash script to load the Apptainer module, download the Docker image, convert the Docker image to a SIF image, and then execute the SIF:
   ```
   $ bash docker_to_apptainer_nextflow_linter.sh general      # Apply general Nextflow script checks
   $ bash docker_to_apptainer_nextflow_linter.sh healthomics   # Apply general checks and AWS HealthOmics specific checks
   $ bash docker_to_apptainer_nextflow-linter.sh config         # Apply linter to nextflow.config file
   ```

<p align="center"><img src="demo_docker2apptainer.gif"/></p>
