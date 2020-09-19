
Docker
------


docker pull tin6150/r4envids 
docker run -it --entrypoint='/bin/bash' tin6150/r4envids 

docker exec -it bash agitated_hermann

# R 
# setwd('DIOS_demonstration/code')


cd /DIOS_demonstration/code
Rscript ./DIOS_demonstration.R  2>&1 | DIOS_demo.out 
# the script was part of the git repo
# need to write in a writable dir
# docker is writable but ephemeral


# it takes a long time to run the whole thing...
# seems can use podman instead of docker, see podman.rst for detail.





Singularity
-----------


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
	Not strictly needed (at least so far), but does throw number of error messages about X11:
	X11 connection rejected because of wrong authentication.urrentCost:0.056596"




singularity exec --bind /run/user/$(id -u) DIOS_demonstration_latest.sif bash -c "cd /DIOS_demonstration/code && /usr/bin/Rscript  /DIOS_demonstration/code/DIOS_demonstration.R"  2>&1 | tee output.log
    # bind mount with /run/user/43143 doesn't help.   the thing tries to write to a pdf file: 
	# Error in (function (file = if (onefile) "Rplots.pdf" else "Rplot%03d.pdf",  : cannot open file 'Rplots.pdf'
	# maybe there is way to set option where to write... 
	# so, map the home dir so that it can create output... 
	# below **works in savio**
	# but when tested on n0145.savio3, not sure why only used a single cpu... that process is not responding to suspend or cancel anyway...
singularity exec --bind .:/mnt DIOS_demonstration_latest.sif bash -c "cd /mnt/code && /usr/bin/Rscript  ./DIOS_demonstration.R"  2>&1 | tee output.log


~~~~

ln DIOS_demonstration_..._mlr3.sif DIOS_demonstration_latest.sif
# hard link, in case do another singularity pull won't overwrite the img

(base) **^ tin zink ~/tin-gh/DIOS_demonstration/code ^**>  
singularity exec DIOS_demonstration_latest.sif /usr/bin/Rscript  ./DIOS_demonstration.R  2>&1 | tee zink.sing.mlr3.nt10i3.out
		n.total   <- 10 # 100
		n.initial <-  3 # 30
	Nope, too small, conflict with other places with hard coded values?
		n.total   <- 74 # 100  # 64 was still too small.
		n.initial <-  8 #  30



