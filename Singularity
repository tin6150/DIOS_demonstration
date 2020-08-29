Bootstrap: docker
From: tin6150/r4envids


# Singularity def, wrap around docker tin6150/r4envids (DIOS_demonstration)

# manual build cmd (singularity 3.2): 
# sudo SINGULARITY_TMPDIR=/global/scratch/tin/tmp singularity build --sandbox ./r4envids.sif Singularity 2>&1  | tee singularity_build.LOG
# sudo SINGULARITY_TMPDIR=/dev/shm singularity build --sandbox ./r4envids.sif Singularity 2>&1  | tee singularity_build.LOG
#
# eg run cmd 
# singularity exec -w r4envids.sif /bin/bash


%post
	touch "_ROOT_DIR_OF_CONTAINER_" ## also is "_CURRENT_DIR_CONTAINER_BUILD" 
	date     >> _ROOT_DIR_OF_CONTAINER_
	hostname >> _ROOT_DIR_OF_CONTAINER_
	echo "Singularity def 2020.0829.1313" >> _ROOT_DIR_OF_CONTAINER_

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
	BUILD = 2020_0829_1313
	MAINTAINER = tin_at_berkeley_edu
	REFERENCES = "https://github.com/tin6150/r4"

%runscript
    #/bin/bash -i 
	R

	

%help
	R programming language env in a container, with many packages from CRAN
	Example run:
	Pull and run via singularity-hub:
	singularity pull --name R shub://tin6150/R4envids
	./R
	singularity exec R /usr/bin/Rscript -e 'library()'
	singularity exec --bind  .:/mnt  myR  /usr/bin/Rscript  /mnt/helloWorld.R > output.txt
    Where helloWorld.R is in your current dir (on the host system)
	See README.rst for additional details.
	source:          https://github.com/tin6150/DIOS_demonstration # tin branch for now
	docker hub:      https://hub.docker.com/repository/docker/tin6150/r4envids
	singularity hub: https://singularity-hub.org/collections/
	//
    Example run with R Studio (with singularity image named as "R"):
	PATH=.:${PATH} rstudio

# vim: noexpandtab nosmarttab noautoindent nosmartindent tabstop=4 shiftwidth=4 paste formatoptions-=cro
