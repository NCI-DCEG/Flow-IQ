#!/bin/bash

RULESET="$1"

module load apptainer

if [ ! -f "linter-rules-for-nextflow-0.2.0.sif" ]; then
  apptainer pull --name linter-rules-for-nextflow-0.2.0.sif \
    docker://jaamarks/linter-rules-for-nextflow:0.2.0
fi

apptainer exec \
  --bind "$PWD:/data" \
  --pwd /work \
  linter-rules-for-nextflow-0.2.0.sif \
  bash /work/check.sh "$RULESET"
