


docker pull tin6150/r4envids 
docker run -it --entrypoint='/bin/bash' tin6150/r4envids 


R 
setwd('DIOS.../code')



cd /DIOS_demonstration/code
Rscript ./DIOS_demonstration.R
# the script was part of the git repo


# takes a long time to run the whole thing...



cd singularity-repo
singularity pull shub://tin6150/DIOS_demonstration
singularity run DIOS_demonstration_latest.sif
singularity exec DIOS_demonstration_latest.sif rstudio # fail on Zink/Mint
	libGL error: No matching fbConfigs or visuals found
	libGL error: failed to load driver: swrast

singularity exec DIOS_demonstration_latest.sif /usr/bin/Rscript  /DIOS_demonstration/code/DIOS_demonstration.R
# -or-
singularity bash DIOS_demonstration_latest.sif 
    /usr/bin/Rscript  /DIOS_demonstration/code/DIOS_demonstration.R

# hmm... hopefully don't need X...
	Warning message:
	In fun(libname, pkgname) : couldn't connect to display "10.0.0.20:17.0"





