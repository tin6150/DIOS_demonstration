
cd  DIOS_demonstration
docker run -p 5999:5999 -v "$PWD":/mnt -it --entrypoint=/opt/conda/bin/jupyter  tin6150/r4envids lab --allow-root  --no-browser --port=5999 --ip=0.0.0.0

http://localhost:5999
http://hima.lbl.gov:5999
login with token shown on URL in terminal where docker was launched.

~~~~

# example run on savio using singularity container
# could be in an interactive node, but best sbatch submit for running by scheduler

cd    code

singularity pull shub://tin6150/DIOS_demonstration

singularity exec DIOS_demonstration_latest.sif /usr/bin/Rscript  ./DIOS_demonstration.R  2>&1 | tee output.log
	# this method use all cpu, tested on n0143.savio3




~~~~~

Kriging
4 times.  potentially parallelized?  they already have their own data frame?

SimAnneal
repeated 3 times sequentially.  but those can be parallelized as each chains are simulated independently.

