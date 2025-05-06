# docker-to-apptainer.sh

`docker-to-apptainer.sh` is a Bash script designed to convert the `linter-rules-for-nextflow` Docker image into an Apptainer-compatible format. This allows you to run a lightweight Nextflow linter Docker image in a High-Performance Computing (HPC) environment that supports Apptainer but not Docker.

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

2. Execute the Bash script to download the Docker image, load the Apptainer module, convert the Docker image to a SIF image, and execute the SIF:
   ```
   $ bash docker-to-apptainer.sh general      # Apply general Nextflow script checks
   $ bash docker-to-apptainer.sh healthomics   # Apply general checks and AWS HealthOmics specific checks
   $ bash docker-to-apptainer.sh config         # Apply linter to nextflow.config file
   ```
