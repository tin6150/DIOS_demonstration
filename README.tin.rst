

# example run on savio using singularity container
# could be in an interactive node, but best sbatch submit for running by scheduler

cd    code

singularity pull shub://tin6150/DIOS_demonstration

singularity exec DIOS_demonstration_latest.sif /usr/bin/Rscript  ./DIOS_demonstration.R  2>&1 | tee output.log
	# this method use all cpu, tested on n0143.savio3




