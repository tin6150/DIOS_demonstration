

# example run on savio using singularity container
# could be in an interactive node, but best sbatch submit for running by scheduler

mkdir singularity-repo
cd    singularity-repo

singularity pull shub://tin6150/DIOS_demonstration

singularity exec DIOS_demonstration_latest.sif /usr/bin/Rscript  /DIOS_demonstration/code/DIOS_demonstration.R  2>&1 | tee output.log




