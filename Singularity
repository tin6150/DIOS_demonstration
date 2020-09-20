Bootstrap: docker
From: tin6150/r4envids

# This is a Singularity def for DIOS demonstration 

# Example run for the DIOS demonstration using Singularity Container 
# singularity pull shub://tin6150/DIOS_demonstration
# singularity exec DIOS_demonstration_latest.sif /usr/bin/Rscript  /DIOS_demonstration/code/DIOS_demonstration.R  2>&1 | tee output.log


#	Advance usage or future tweak of this container:
#	Alternate example run:
# 	Pull and run via singularity-hub:
#	singularity pull --name R shub://tin6150/DIOS_demonstration
#	./R
#	singularity exec R /usr/bin/Rscript -e 'library()'
#	singularity exec --bind  .:/mnt  R  /usr/bin/Rscript  /mnt/helloWorld.R > output.txt
#   Where helloWorld.R is in your current dir (on the host system)

#	LINKS
#	git repo:        https://github.com/tin6150/DIOS_demonstration # tin branch for now
#	docker hub:      https://hub.docker.com/repository/docker/tin6150/r4envids
#	singularity hub: https://singularity-hub.org/collections/4713

 
# manual build cmd (singularity 3.6.1): 
# sudo SINGULARITY_TMPDIR=/tmp  singularity build --sandbox ./r4envids.sif Singularity 2>&1  | tee singularity_build.log


%post
	touch "_ROOT_DIR_OF_CONTAINER_" ## also is "_CURRENT_DIR_CONTAINER_BUILD" 
	date     >> _ROOT_DIR_OF_CONTAINER_
	hostname >> _ROOT_DIR_OF_CONTAINER_
	echo "Singularity def 2020.0910.1437 procps" >> _ROOT_DIR_OF_CONTAINER_
	echo "Singularity def 2020.0918.1501 R::snow" >> _ROOT_DIR_OF_CONTAINER_

	# docker run as root, but singularity may run as user, so adding these hacks here
	mkdir -p /global/scratch/tin
	mkdir -p /global/home/users/tin
	mkdir -p /home/tin
	mkdir -p /home/tmp
	mkdir -p /Downloads
	chown    43143 /global/scratch/tin
	chown    43143 /global/home/users/tin
	chown -R 43143 /home
	#chown -R 43143 /home/tin
	chown -R 43143 /opt
	chown -R 43143 /Downloads
	chmod 1777 /home/tmp

    
%environment
	TZ=PST8PDT
	export TZ 

%labels
	BUILD = 2020_0918_1501_R__snow
	MAINTAINER = tin_at_berkeley_edu
	REFERENCES = "https://github.com/tin6150/r4"

%runscript
    #/bin/bash -i 
	R

	
# `singularity run-help $CONTAINER_NAME` will show info below
%help
	Example run for the DIOS demonstration using Singularity Container 
	singularity pull shub://tin6150/DIOS_demonstration
	singularity exec --bind .:/mnt DIOS_demonstration_latest.sif bash -c "cd /mnt/code && /usr/bin/Rscript  ./DIOS_demonstration.R"  2>&1 | tee output.log

# vim: noexpandtab nosmarttab noautoindent nosmartindent tabstop=4 shiftwidth=4 paste formatoptions-=cro
