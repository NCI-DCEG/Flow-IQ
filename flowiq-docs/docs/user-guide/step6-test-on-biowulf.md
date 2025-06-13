# Step 6: Test on Biowulf HPC

When running on Biowulf HPC, we need to configure settings specific to that environment—most importantly, specifying which **executor** to use.

This is typically done using **profiles** in the `nextflow.config` file. A profile allows you to bundle environment-specific settings like the executor type, memory and CPU allocations, and other resource or cluster-specific configurations. You can activate a profile using the `-profile` option when launching a pipeline.

On Biowulf, the key setting is:

```groovy
executor = 'slurm'
```

Let’s break down why this matters.

---

## ✅ What happens when `executor = 'slurm'` is set?

When you specify `executor = 'slurm'`, Nextflow:

* Submits jobs using `sbatch`
* Translates process directives (`cpus`, `memory`, `time`) into `#SBATCH` options
* Automatically manages cluster queue behavior (submission rate, polling interval, retries, etc.)
* Ensures each process runs on a compute node, not the local machine

This setup is essential for proper resource allocation and performance on clusters like Biowulf.

---

## ❌ What happens if `executor` is *not* set?

If you don’t specify an executor, Nextflow defaults to:

```groovy
executor = 'local'
```

Which means:

* All processes run on the same machine where `nextflow run` is executed
* No jobs are submitted to Slurm
* Resource directives like `--mem`, `--cpus`, and `--time` are not interpreted as SLURM constraints
* You’re simply multithreading on a single node—either in an interactive session or within an `sbatch`-wrapped shell

This is **not** what you want on an HPC cluster like Biowulf.

---

## How and where are resources set?

Just like the executor, resources like CPU, memory, and time are set through configuration files and Nextflow process labels.

For example, in `manta/germline/main.nf`:

```groovy
process MANTA_GERMLINE {
    tag "$meta.id"
    label 'process_medium'
    label 'error_retry'
}
```

The label `process_medium` refers to this block in `conf/base.config`:

```groovy
withLabel:process_medium {
    cpus   = { 6     * task.attempt }
    memory = { 36.GB * task.attempt }
    time   = { 8.h   * task.attempt }
}
```

This setup dynamically scales resources with retry attempts.

---

## Biowulf Support in nf-core/configs

Biowulf is one of the many clusters pre-configured in the [nf-core/configs](https://github.com/nf-core/configs) repository. This means you don’t have to define Biowulf-specific settings yourself.

You can simply run:

```bash
nextflow run main.nf -c nextflow.config -profile biowulf
```

Nextflow will automatically pull the Biowulf configuration from:

🔗 [https://github.com/nf-core/configs/blob/master/conf/biowulf.config](https://github.com/nf-core/configs/blob/master/conf/biowulf.config)

This profile sets `executor = 'slurm'`, defines staging behavior, handles file caching, and more—ready to use out of the box.

For more info, see:

🔗 [Biowulf-specific Nextflow docs at NIH](https://hpc.nih.gov/apps/nextflow.html)

🔗 [nf-core/configs homepage](https://nf-co.re/configs)

---

## ⚠️ Naming Conflicts When Adding Your Own Profiles

If you define your own `biowulf` profile in your local `nextflow.config`, it may **conflict** with the official one from `nf-core/configs`. That’s because Nextflow prioritizes remote profiles when you use `-profile`.

To avoid this, use a different name for custom configs:

```groovy
profiles {
  biowulf_custom {
    process.executor = 'slurm'
    // your overrides here
  }
}
```

Then launch with:

```bash
nextflow run main.nf -c nextflow.config -profile biowulf_custom
```

## How to Execute
Create a batch input file (e.g. `run_manta_on_biowulf.sh`) to run the master Nextflow process.
For example:
```bash
#! /bin/bash
#SBATCH --job-name=nextflow-main
#SBATCH --cpus-per-task=4
#SBATCH --mem=4G
#SBATCH --gres=lscratch:200
#SBATCH --time=24:00:00

module load nextflow
export NXF_SINGULARITY_CACHEDIR=/data/$USER/nxf_singularity_cache;
export SINGULARITY_CACHEDIR=/data/$USER/.singularity;
export TMPDIR=/lscratch/$SLURM_JOB_ID
export NXF_JVM_ARGS="-Xms2g -Xmx4g"

nextflow run main.nf -c nextflow.config -profile conda,biowulf
```

Submit the job using `sbatch`:
```
sbatch nf_main.sh
```

> **Note:** Find more details specific to using Nextflow on Biowulf HPC, see the official documentation at: https://hpc.nih.gov/apps/nextflow.html

<br>

A template submission script, `run_manta_on_biowulf.sh`, is also included in the `nci-dceg-flowiq` directory of this repo for your reference.
