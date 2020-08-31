

used podman from centos 8 (vagrant_centos8).

Mostly worked.
But there were some error that was a bit unsettling.

at the end of podman build:
	[tin@viagra8 DIOS_demonstration]$ podman build -t tin6150/r4envids -f Dockerfile .  | tee Dockerfile.monolithic.LOG5
	[...]
	STEP 14: ENV TEST_DOCKER_ENV_REF https://vsupalov.com/docker-arg-env-variable-guide/#setting-env-values
	701f88b2eb21079f14e85f9f89e242048ab032ddab3ebb92fb0967bbf938a32e
	STEP 15: ENTRYPOINT [ "R" ]
	STEP 16: COMMIT tin6150/r4envids
	85964c39af4ad7e87481e9ca126cddf528fd0106b3e95db02d4db0a9623ce178 
	ERRO[3656] unable to close namespace: "close /proc/2901/ns/user: bad file descriptor"   **<<**
	[tin@viagra8 DIOS_demonstration]$ echo $?
	0


when doing push to registry:

	[tin@viagra8 DIOS_demonstration]$ podman push tin6150/r4envids
	Getting image source signatures
	Copying blob 7a9621ee0179 skipped: already exists
	Copying blob 27ac778f7055 skipped: already exists
	Copying blob bd0898275f20 skipped: already exists
	Copying blob d363c4db28af skipped: already exists
	Copying blob ef0982811f40 skipped: already exists
	Copying blob 785d1cb27d7b skipped: already exists
	Copying blob f2dbbd35552d done
	Copying blob a457865a21c4 done
	Copying blob 7269a7c39cc3 done
	Copying blob c9ca87d8f65f done
	Copying blob 267204440f04 done
	Copying config 85964c39af done
	Writing manifest to image destination
	Storing signatures
	ERRO[1688] unable to close namespace: "close /proc/2901/ns/user: bad file descriptor"  **<<**
	[tin@viagra8 DIOS_demonstration]$ echo $?
	0
	[tin@viagra8 DIOS_demonstration]$ 

so for container seems to work with no detrimental effect.

was able to pull it
**^ tin bofh ~/tin-gh/scg-ansible/host_vars ^**>  sudo docker run -it tin6150/r4envids

**^ tin bofh ~/tin-gh/scg-ansible/host_vars ^**>  sudo docker pull tin6150/r4envids                                                                 
Using default tag: latest
latest: Pulling from tin6150/r4envids
2dffa903b83a: Already exists 
10f3fdbe572d: Already exists 
663fe05835c5: Already exists 
7a88b43f1097: Already exists 
ff9b12da32ab: Already exists 
bd3fedd8743f: Already exists 
21678b468566: Pull complete 
cddf1ef23fd1: Pull complete 
9c4e56795e4a: Pull complete 
2b2601546dfc: Pull complete 
8466fad94300: Pull complete 
Digest: sha256:8801eee7b7767fcb17d2aaa8ff255ae9266d98549e02e6c2b6dacc8ba1232719
Status: Downloaded newer image for tin6150/r4envids:latest

**^ tin bofh ~/tin-gh/scg-ansible/host_vars ^**>  sudo docker run -it tin6150/r4envids

**^ tin bofh ~/tin-gh/scg-ansible/host_vars ^**>  sudo docker run -it --entrypoint="/usr/bin/Rscript" tin6150/r4envids  -e 'library()' 
cannot use | or > with the above command.  docker likely doing something funky with the I/O stream.

**^ tin bofh ~/tin-gh/scg-ansible/host_vars ^**>  sudo docker run  --entrypoint="/usr/bin/Rscript" tin6150/r4envids  -e 'library()'  | wc 
	191



singularity-hub problem though

	Storing signatures
	2020/08/29 23:22:55 info unpack layer: sha256:2dffa903b83a05e8f7056f2d8f378ea21af1cbc9a30f68bb9f93f103520963cb
	[31mFATAL: [0m While performing build: packer failed to pack: while unpacking tmpfs: error unpacking rootfs: unpack layer: read next entry: archive/tar: invalid tar header   **<<**
	ERROR Build error. See above for details



So, actually end up doing a hub.docker.com cloud build based on the Dockerfile.
(sudo docker build -t tin6150/r4envids -f Dockerfile .  | tee Dockerfile.monolithic.LOG on bofh completed without error)

doing singularity build.

Note that Zink (Mint) has R 3.4.4 and many of the required packages, like cowplot, don't install in this old R.
May have to find way to install archived packages, or use this containerized R, which seems to be 4.0.2 !

~~~~

even when pulling a docker-hub build, there are strange errors:

	[tin@viagra8 DIOS_demonstration]$ docker pull tin6150/r4envids
	Emulate Docker CLI using podman. Create /etc/containers/nodocker to quiet msg.
	Trying to pull registry.access.redhat.com/tin6150/r4envids...
	  name unknown: Repo not found
	Trying to pull registry.redhat.io/tin6150/r4envids...
	  unable to retrieve auth token: invalid username/password: unauthorized: Please login to the Red Hat Registry using your Customer Portal credentials. Further instructions can be found here: https://access.redhat.com/RegistryAuthentication
	Trying to pull docker.io/tin6150/r4envids...
	Getting image source signatures
	Copying blob bd3fedd8743f skipped: already exists
	Copying blob 10f3fdbe572d skipped: already exists
	Copying blob 2dffa903b83a skipped: already exists
	Copying blob 663fe05835c5 skipped: already exists
	Copying blob ff9b12da32ab skipped: already exists
	Copying blob 7a88b43f1097 skipped: already exists
	Copying blob d26a5fac2414 done
	Copying blob 696e01b41083 done
	Copying blob 562aa4f153dd done
	Copying blob 9d2e3cc64ef0 done
	Copying blob 237a99634096 done
	Copying config 9b2733a516 done
	Writing manifest to image destination
	Storing signatures
	9b2733a516d243dbec0d550ba30f75f1583d82c37dc9943a79f1cfacfa23942b
	ERRO[0373] unable to close namespace: "close /proc/2901/ns/user: bad file descriptor"


running:  seems fine.  typical warning messages as when using singularity or docker:

	[tin@viagra8 DIOS_demonstration]$ docker run -it --entrypoint='/bin/bash' tin6150/r4envids
	Emulate Docker CLI using podman. Create /etc/containers/nodocker to quiet msg.
	root@2d6db8d1e7d0:/# cd DIOS_demonstration/code
	root@2d6db8d1e7d0:/DIOS_demonstration/code# ls
	DIOS_demonstration_functions.R	DIOS_demonstration.R
	root@2d6db8d1e7d0:/DIOS_demonstration/code# Rscript ./DIOS_demonstration.R 2>&1 | tee DIOS.podman.out
	Loading required package: sp

	********************************************************
	Note: As of version 1.0.0, cowplot does not change the
	  default ggplot2 theme anymore. To recover the previous
	  behavior, execute:
	  theme_set(theme_cowplot())
	********************************************************

	--------------------------------------------------------------
	 Analysis of Geostatistical Data
	 For an Introduction to geoR go to http://www.leg.ufpr.br/geoR
	 geoR version 1.8-1 (built on 2020-02-08) is now loaded
	--------------------------------------------------------------

	Warning message:
	no DISPLAY variable so Tk is not available
	Loading required package: iterators
	Loading required package: parallel
	── Attaching packages ─────────────────────────────────────── tidyverse 1.3.0 ──
	✔ tibble  3.0.1     ✔ dplyr   0.8.5
	✔ tidyr   1.1.2     ✔ stringr 1.4.0
	✔ readr   1.3.1     ✔ forcats 0.5.0
	✔ purrr   0.3.4
	[...]
	likfit: end of numerical maximisation.
	[using conditional Gaussian simulation]
	[using conditional Gaussian simulation]
	[using conditional Gaussian simulation]
	[using conditional Gaussian simulation]




